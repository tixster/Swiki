import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import SwikiModels

public typealias SwikiQuery = [String: String?]

public enum SwikiHTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum SwikiClientError: Error, LocalizedError, Sendable {
    case invalidURL(path: String)
    case invalidResponse
    case badStatusCode(Int, String?)
    case emptyResponse
    case graphQLErrors([String])
    case graphQLDataMissing

    public var errorDescription: String? {
        switch self {
        case let .invalidURL(path):
            "Invalid URL for path: \(path)"
        case .invalidResponse:
            "Invalid response from server"
        case let .badStatusCode(statusCode, body):
            if let body, !body.isEmpty {
                "Request failed with HTTP \(statusCode): \(body)"
            } else {
                "Request failed with HTTP \(statusCode)"
            }
        case .emptyResponse:
            "Response body is empty"
        case let .graphQLErrors(messages):
            "GraphQL returned errors: \(messages.joined(separator: "; "))"
        case .graphQLDataMissing:
            "GraphQL response does not contain data"
        }
    }
}

public enum SwikiAPIVersion: String, Sendable {
    case v1 = "1.0"
    case v2 = "2.0"
}

final class SwikiHTTPTransport: Sendable {
    private let configuration: SwikiConfiguration
    private let session: URLSession
    private let oauthClient: SwikiOAuthClient?

    init(
        configuration: SwikiConfiguration,
        session: URLSession,
        oauthClient: SwikiOAuthClient? = nil
    ) {
        self.configuration = configuration
        self.session = session
        self.oauthClient = oauthClient
    }

    func request<Response: Decodable>(
        version: SwikiAPIVersion,
        method: SwikiHTTPMethod,
        path: String,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:]
    ) async throws -> Response {
        let (data, _) = try await execute(
            version: version,
            method: method,
            path: path,
            id: id,
            action: action,
            query: query,
            bodyData: nil
        )

        guard !data.isEmpty else {
            throw SwikiClientError.emptyResponse
        }

        return try makeDecoder().decode(Response.self, from: data)
    }

    func request<Response: Decodable, Body: Encodable>(
        version: SwikiAPIVersion,
        method: SwikiHTTPMethod,
        path: String,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws -> Response {
        let bodyData = try makeEncoder().encode(body)
        let (data, _) = try await execute(
            version: version,
            method: method,
            path: path,
            id: id,
            action: action,
            query: query,
            bodyData: bodyData
        )

        guard !data.isEmpty else {
            throw SwikiClientError.emptyResponse
        }

        return try makeDecoder().decode(Response.self, from: data)
    }

    func request(
        version: SwikiAPIVersion,
        method: SwikiHTTPMethod,
        path: String,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:]
    ) async throws {
        _ = try await execute(
            version: version,
            method: method,
            path: path,
            id: id,
            action: action,
            query: query,
            bodyData: nil
        )
    }

    func request<Body: Encodable>(
        version: SwikiAPIVersion,
        method: SwikiHTTPMethod,
        path: String,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws {
        let bodyData = try makeEncoder().encode(body)
        _ = try await execute(
            version: version,
            method: method,
            path: path,
            id: id,
            action: action,
            query: query,
            bodyData: bodyData
        )
    }

    func graphQL(request: GraphQLRequest) async throws -> GraphQLResult {
        let requestBody = try GraphQLJSONEncoder().encode(request)
        let (data, _) = try await executeGraphQL(bodyData: requestBody)

        if data.isEmpty {
            return GraphQLResult()
        }

        return try JSONDecoder().decode(GraphQLResult.self, from: data)
    }

    func graphQL<Response: Decodable>(
        request: GraphQLRequest,
        responseType: Response.Type = Response.self,
        requireNoErrors: Bool = true
    ) async throws -> Response {
        let result = try await graphQL(request: request)
        if requireNoErrors, !result.errors.isEmpty {
            throw SwikiClientError.graphQLErrors(result.errors.map(\.message))
        }

        guard let dataMap = result.data else {
            throw SwikiClientError.graphQLDataMissing
        }

        let payload = try GraphQLJSONEncoder().encode(dataMap)
        return try makeGraphQLDecoder().decode(Response.self, from: payload)
    }

    private func execute(
        version: SwikiAPIVersion,
        method: SwikiHTTPMethod,
        path: String,
        id: String?,
        action: String?,
        query: SwikiQuery,
        bodyData: Data?
    ) async throws -> (Data, HTTPURLResponse) {
        let fullPath = makePath(path: path, id: id, action: action)
        guard let url = makeURL(version: version, path: fullPath, query: query) else {
            throw SwikiClientError.invalidURL(path: fullPath)
        }

        return try await executeAuthenticated(url: url, method: method, bodyData: bodyData)
    }

    private func executeGraphQL(bodyData: Data?) async throws -> (Data, HTTPURLResponse) {
        try await executeAuthenticated(url: configuration.graphQLURL, method: .post, bodyData: bodyData)
    }

    private func executeAuthenticated(
        url: URL,
        method: SwikiHTTPMethod,
        bodyData: Data?
    ) async throws -> (Data, HTTPURLResponse) {
        let initialRequest = try await buildRequest(url: url, method: method, bodyData: bodyData)
        let (initialData, initialResponse) = try await perform(request: initialRequest)
        guard let initialHTTPResponse = initialResponse as? HTTPURLResponse else {
            throw SwikiClientError.invalidResponse
        }

        if initialHTTPResponse.statusCode == 401,
           let oauthClient,
           try await oauthClient.refreshTokenIfPossible() {
            let retryRequest = try await buildRequest(url: url, method: method, bodyData: bodyData)
            let (retryData, retryResponse) = try await perform(request: retryRequest)
            guard let retryHTTPResponse = retryResponse as? HTTPURLResponse else {
                throw SwikiClientError.invalidResponse
            }

            guard (200...299).contains(retryHTTPResponse.statusCode) else {
                let responseBody = retryData.isEmpty ? nil : String(data: retryData, encoding: .utf8)
                throw SwikiClientError.badStatusCode(retryHTTPResponse.statusCode, responseBody)
            }

            return (retryData, retryHTTPResponse)
        }

        guard (200...299).contains(initialHTTPResponse.statusCode) else {
            let responseBody = initialData.isEmpty ? nil : String(data: initialData, encoding: .utf8)
            throw SwikiClientError.badStatusCode(initialHTTPResponse.statusCode, responseBody)
        }

        return (initialData, initialHTTPResponse)
    }

    private func buildRequest(
        url: URL,
        method: SwikiHTTPMethod,
        bodyData: Data?
    ) async throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(configuration.userAgent, forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let oauthAccessToken = try await oauthClient?.validAccessToken()
        let staticAccessToken = configuration.accessToken
        if let accessToken = oauthAccessToken ?? staticAccessToken, !accessToken.isEmpty {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        let headerClientId = configuration.clientId ?? configuration.oauthCredentials?.clientId
        if let headerClientId, !headerClientId.isEmpty {
            request.setValue(headerClientId, forHTTPHeaderField: "X-Client-Id")
        }

        for (key, value) in configuration.additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let bodyData {
            request.httpBody = bodyData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }

    private func perform(request: URLRequest) async throws -> (Data, URLResponse) {
        if configuration.isRpsRpmRestrictionsEnabled {
            return try await SwikiActor.shared.submit {
                try await self.session.data(for: request)
            }
        }
        return try await session.data(for: request)
    }

    private func makePath(path: String, id: String?, action: String?) -> String {
        var components = path.split(separator: "/").map(String.init)
        if let id, !id.isEmpty {
            components.append(id)
        }
        if let action, !action.isEmpty {
            components.append(action)
        }
        return components.joined(separator: "/")
    }

    private func makeURL(
        version: SwikiAPIVersion,
        path: String,
        query: SwikiQuery
    ) -> URL? {
        var url = configuration.baseURL
        url.appendPathComponent(version.rawValue)
        path.split(separator: "/").forEach { segment in
            url.appendPathComponent(String(segment))
        }

        guard !query.isEmpty else {
            return url
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = query.compactMap { key, value in
            guard let value else { return nil }
            return URLQueryItem(name: key, value: value)
        }
        return components?.url
    }

    private func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.set(apiType: .rest)
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()

            if let timestamp = try? container.decode(Double.self) {
                return Date(timeIntervalSince1970: timestamp)
            }

            if let timestamp = try? container.decode(Int.self) {
                return Date(timeIntervalSince1970: TimeInterval(timestamp))
            }

            let rawValue = try container.decode(String.self)
            if let parsed = Self.parseDate(rawValue) {
                return parsed
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unsupported date format: \(rawValue)"
            )
        }
        return decoder
    }

    private func makeGraphQLDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.set(apiType: .graphQL)
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()

            if let timestamp = try? container.decode(Double.self) {
                return Date(timeIntervalSince1970: timestamp)
            }

            if let timestamp = try? container.decode(Int.self) {
                return Date(timeIntervalSince1970: TimeInterval(timestamp))
            }

            let rawValue = try container.decode(String.self)
            if let parsed = Self.parseDate(rawValue) {
                return parsed
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unsupported date format: \(rawValue)"
            )
        }
        return decoder
    }

    private func makeEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

    private static func parseDate(_ rawValue: String) -> Date? {
        let fractional = ISO8601DateFormatter()
        fractional.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let parsed = fractional.date(from: rawValue) {
            return parsed
        }

        let basic = ISO8601DateFormatter()
        basic.formatOptions = [.withInternetDateTime]
        if let parsed = basic.date(from: rawValue) {
            return parsed
        }

        let yyyyMMdd = DateFormatter()
        yyyyMMdd.dateFormat = "yyyy-MM-dd"
        yyyyMMdd.locale = Locale(identifier: "en_US_POSIX")
        yyyyMMdd.timeZone = TimeZone(secondsFromGMT: 0)
        return yyyyMMdd.date(from: rawValue)
    }
}
