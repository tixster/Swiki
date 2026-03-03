import Foundation
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

    init(
        configuration: SwikiConfiguration,
        session: URLSession
    ) {
        self.configuration = configuration
        self.session = session
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

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(configuration.userAgent, forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        if let accessToken = configuration.accessToken, !accessToken.isEmpty {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        if let clientId = configuration.clientId, !clientId.isEmpty {
            request.setValue(clientId, forHTTPHeaderField: "X-Client-Id")
        }

        for (key, value) in configuration.additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let bodyData {
            request.httpBody = bodyData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let preparedRequest = request
        let (data, response): (Data, URLResponse)
        if configuration.isRpsRpmRestrictionsEnabled {
            (data, response) = try await SwikiActor.shared.submit {
                try await self.session.data(for: preparedRequest)
            }
        } else {
            (data, response) = try await session.data(for: preparedRequest)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw SwikiClientError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let responseBody = data.isEmpty ? nil : String(data: data, encoding: .utf8)
            throw SwikiClientError.badStatusCode(httpResponse.statusCode, responseBody)
        }

        return (data, httpResponse)
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
