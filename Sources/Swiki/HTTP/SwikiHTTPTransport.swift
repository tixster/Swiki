import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Logging
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
    case v1 = ""
    case v2 = "v2"
}

final class SwikiHTTPTransport: Sendable {
    private enum RequestKind: Sendable {
        case rest(version: SwikiAPIVersion, path: String)
        case graphQL(operationName: String?)
    }

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
        let (data, _) = try await executeGraphQL(
            bodyData: requestBody,
            operationName: request.operationName
        )

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

        return try await executeAuthenticated(
            url: url,
            method: method,
            bodyData: bodyData,
            kind: .rest(version: version, path: fullPath)
        )
    }

    private func executeGraphQL(
        bodyData: Data?,
        operationName: String?
    ) async throws -> (Data, HTTPURLResponse) {
        try await executeAuthenticated(
            url: configuration.graphQLURL,
            method: .post,
            bodyData: bodyData,
            kind: .graphQL(operationName: operationName)
        )
    }

    private func executeAuthenticated(
        url: URL,
        method: SwikiHTTPMethod,
        bodyData: Data?,
        kind: RequestKind
    ) async throws -> (Data, HTTPURLResponse) {
        let requestID = String(UUID().uuidString.prefix(8))
        let initialRequest = try await buildRequest(url: url, method: method, bodyData: bodyData)
        let initialStartedAt = Date()
        logRequestStart(
            requestID: requestID,
            kind: kind,
            method: method,
            url: url,
            attempt: 1,
            bodyData: bodyData
        )

        let (initialData, initialResponse): (Data, URLResponse)
        do {
            (initialData, initialResponse) = try await perform(request: initialRequest)
        } catch {
            logFailure(
                requestID: requestID,
                kind: kind,
                method: method,
                url: url,
                attempt: 1,
                statusCode: nil,
                bodyData: bodyData,
                responseData: nil,
                startedAt: initialStartedAt,
                error: error
            )
            throw error
        }

        guard let initialHTTPResponse = initialResponse as? HTTPURLResponse else {
            logFailure(
                requestID: requestID,
                kind: kind,
                method: method,
                url: url,
                attempt: 1,
                statusCode: nil,
                bodyData: bodyData,
                responseData: initialData,
                startedAt: initialStartedAt,
                error: SwikiClientError.invalidResponse
            )
            throw SwikiClientError.invalidResponse
        }

        if initialHTTPResponse.statusCode == 401,
           let oauthClient,
           try await oauthClient.refreshTokenIfPossible() {
            log(
                level: .warning,
                message: "🟡 🔁 API REQUEST RETRY (401 after refresh)",
                metadata: requestMetadata(
                    requestID: requestID,
                    kind: kind,
                    method: method,
                    url: url,
                    attempt: 1,
                    statusCode: initialHTTPResponse.statusCode,
                    requestBodyBytes: bodyData?.count,
                    responseBodyBytes: initialData.count,
                    durationMs: durationMs(since: initialStartedAt),
                    error: nil
                )
            )

            let retryRequest = try await buildRequest(url: url, method: method, bodyData: bodyData)
            let retryStartedAt = Date()
            logRequestStart(
                requestID: requestID,
                kind: kind,
                method: method,
                url: url,
                attempt: 2,
                bodyData: bodyData
            )

            let (retryData, retryResponse): (Data, URLResponse)
            do {
                (retryData, retryResponse) = try await perform(request: retryRequest)
            } catch {
                logFailure(
                    requestID: requestID,
                    kind: kind,
                    method: method,
                    url: url,
                    attempt: 2,
                    statusCode: nil,
                    bodyData: bodyData,
                    responseData: nil,
                    startedAt: retryStartedAt,
                    error: error
                )
                throw error
            }

            guard let retryHTTPResponse = retryResponse as? HTTPURLResponse else {
                logFailure(
                    requestID: requestID,
                    kind: kind,
                    method: method,
                    url: url,
                    attempt: 2,
                    statusCode: nil,
                    bodyData: bodyData,
                    responseData: retryData,
                    startedAt: retryStartedAt,
                    error: SwikiClientError.invalidResponse
                )
                throw SwikiClientError.invalidResponse
            }

            guard (200...299).contains(retryHTTPResponse.statusCode) else {
                let responseBody = retryData.isEmpty ? nil : String(data: retryData, encoding: .utf8)
                let error = SwikiClientError.badStatusCode(retryHTTPResponse.statusCode, responseBody)
                logFailure(
                    requestID: requestID,
                    kind: kind,
                    method: method,
                    url: url,
                    attempt: 2,
                    statusCode: retryHTTPResponse.statusCode,
                    bodyData: bodyData,
                    responseData: retryData,
                    startedAt: retryStartedAt,
                    error: error
                )
                throw SwikiClientError.badStatusCode(retryHTTPResponse.statusCode, responseBody)
            }

            logSuccess(
                requestID: requestID,
                kind: kind,
                method: method,
                url: url,
                attempt: 2,
                statusCode: retryHTTPResponse.statusCode,
                bodyData: bodyData,
                responseData: retryData,
                startedAt: retryStartedAt
            )
            return (retryData, retryHTTPResponse)
        }

        guard (200...299).contains(initialHTTPResponse.statusCode) else {
            let responseBody = initialData.isEmpty ? nil : String(data: initialData, encoding: .utf8)
            let error = SwikiClientError.badStatusCode(initialHTTPResponse.statusCode, responseBody)
            logFailure(
                requestID: requestID,
                kind: kind,
                method: method,
                url: url,
                attempt: 1,
                statusCode: initialHTTPResponse.statusCode,
                bodyData: bodyData,
                responseData: initialData,
                startedAt: initialStartedAt,
                error: error
            )
            throw SwikiClientError.badStatusCode(initialHTTPResponse.statusCode, responseBody)
        }

        logSuccess(
            requestID: requestID,
            kind: kind,
            method: method,
            url: url,
            attempt: 1,
            statusCode: initialHTTPResponse.statusCode,
            bodyData: bodyData,
            responseData: initialData,
            startedAt: initialStartedAt
        )
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

    private func logRequestStart(
        requestID: String,
        kind: RequestKind,
        method: SwikiHTTPMethod,
        url: URL,
        attempt: Int,
        bodyData: Data?
    ) {
        log(
            level: .debug,
            message: "🔵 ───── API REQUEST START ─────",
            metadata: requestMetadata(
                requestID: requestID,
                kind: kind,
                method: method,
                url: url,
                attempt: attempt,
                statusCode: nil,
                requestBodyBytes: bodyData?.count,
                responseBodyBytes: nil,
                durationMs: nil,
                error: nil
            )
        )
    }

    private func logSuccess(
        requestID: String,
        kind: RequestKind,
        method: SwikiHTTPMethod,
        url: URL,
        attempt: Int,
        statusCode: Int,
        bodyData: Data?,
        responseData: Data,
        startedAt: Date
    ) {
        log(
            level: .info,
            message: "🟢 ───── API REQUEST SUCCESS ─────",
            metadata: requestMetadata(
                requestID: requestID,
                kind: kind,
                method: method,
                url: url,
                attempt: attempt,
                statusCode: statusCode,
                requestBodyBytes: bodyData?.count,
                responseBodyBytes: responseData.count,
                durationMs: durationMs(since: startedAt),
                error: nil
            )
        )
    }

    private func logFailure(
        requestID: String,
        kind: RequestKind,
        method: SwikiHTTPMethod,
        url: URL,
        attempt: Int,
        statusCode: Int?,
        bodyData: Data?,
        responseData: Data?,
        startedAt: Date,
        error: Error
    ) {
        log(
            level: .error,
            message: "🔴 ───── API REQUEST FAILED ─────",
            metadata: requestMetadata(
                requestID: requestID,
                kind: kind,
                method: method,
                url: url,
                attempt: attempt,
                statusCode: statusCode,
                requestBodyBytes: bodyData?.count,
                responseBodyBytes: responseData?.count,
                durationMs: durationMs(since: startedAt),
                error: String(describing: error)
            )
        )
    }

    private func requestMetadata(
        requestID: String,
        kind: RequestKind,
        method: SwikiHTTPMethod,
        url: URL,
        attempt: Int,
        statusCode: Int?,
        requestBodyBytes: Int?,
        responseBodyBytes: Int?,
        durationMs: Int?,
        error: String?
    ) -> Logger.Metadata {
        var metadata: Logger.Metadata = [
            "request_id": .string(requestID),
            "kind": .string(requestKindDescription(kind)),
            "method": .string(method.rawValue),
            "url": .string(url.absoluteString),
            "attempt": .stringConvertible(attempt)
        ]

        if let statusCode {
            metadata["status"] = .stringConvertible(statusCode)
        }
        if let requestBodyBytes {
            metadata["request_body_bytes"] = .stringConvertible(requestBodyBytes)
        }
        if let responseBodyBytes {
            metadata["response_body_bytes"] = .stringConvertible(responseBodyBytes)
        }
        if let durationMs {
            metadata["duration_ms"] = .stringConvertible(durationMs)
        }
        if let error {
            metadata["error"] = .string(error)
        }

        return metadata
    }

    private func requestKindDescription(_ kind: RequestKind) -> String {
        switch kind {
        case let .rest(version, path):
            return "rest:\(version.rawValue):\(path)"
        case let .graphQL(operationName):
            if let operationName, !operationName.isEmpty {
                return "graphql:\(operationName)"
            }
            return "graphql"
        }
    }

    private func durationMs(since startedAt: Date) -> Int {
        Int(Date().timeIntervalSince(startedAt) * 1_000)
    }

    private func log(level: Logger.Level, message: String, metadata: Logger.Metadata) {
        guard let logger = configuration.apiLogger else {
            return
        }

        logger.log(level: level, "\(message)", metadata: metadata)
    }
}
