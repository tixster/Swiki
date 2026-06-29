import Foundation

public struct SwikiResourceClient<Model: Decodable & Sendable>: Sendable {
    private let transport: SwikiHTTPTransport
    private let version: SwikiAPIVersion
    private let path: String

    init(
        transport: SwikiHTTPTransport,
        version: SwikiAPIVersion,
        path: String
    ) {
        self.transport = transport
        self.version = version
        self.path = path
    }

    @concurrent
    public func list(query: SwikiQuery = [:]) async throws -> [Model] {
        try await transport.request(version: version, method: .get, path: path, query: query)
    }

    @concurrent
    public func get(id: String, query: SwikiQuery = [:]) async throws -> Model {
        try await transport.request(version: version, method: .get, path: path, id: id, query: query)
    }

    @concurrent
    public func create<Body: Encodable & Sendable>(
        body: Body,
        query: SwikiQuery = [:]
    ) async throws -> Model {
        try await transport.request(version: version, method: .post, path: path, query: query, body: body)
    }

    @concurrent
    public func update<Body: Encodable & Sendable>(
        id: String,
        body: Body,
        query: SwikiQuery = [:],
        method: SwikiHTTPMethod = .put
    ) async throws -> Model {
        try await transport.request(version: version, method: method, path: path, id: id, query: query, body: body)
    }

    @concurrent
    public func delete(id: String, query: SwikiQuery = [:]) async throws {
        try await transport.request(version: version, method: .delete, path: path, id: id, query: query)
    }

    @concurrent
    public func request<Response: Decodable & Sendable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        route: String? = nil,
        query: SwikiQuery = [:]
    ) async throws -> Response {
        try await transport.request(
            version: version,
            method: method,
            path: path,
            id: id,
            route: route,
            query: query
        )
    }

    @concurrent
    public func request<Response: Decodable & Sendable, Body: Encodable & Sendable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        route: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws -> Response {
        try await transport.request(
            version: version,
            method: method,
            path: path,
            id: id,
            route: route,
            query: query,
            body: body
        )
    }

    @concurrent
    public func request(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        route: String? = nil,
        query: SwikiQuery = [:]
    ) async throws {
        try await transport.request(
            version: version,
            method: method,
            path: path,
            id: id,
            route: route,
            query: query
        )
    }

    @concurrent
    public func request<Body: Encodable & Sendable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        route: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws {
        try await transport.request(
            version: version,
            method: method,
            path: path,
            id: id,
            route: route,
            query: query,
            body: body
        )
    }

}

protocol SwikiResourceSubclient: Sendable {
    associatedtype Model: Decodable & Sendable
    var resourceClient: SwikiResourceClient<Model> { get }
}

extension SwikiResourceSubclient {

    @concurrent
    func list(query: SwikiQuery = [:]) async throws -> [Model] {
        try await resourceClient.list(query: query)
    }

    @concurrent
    func get(id: String, query: SwikiQuery = [:]) async throws -> Model {
        try await resourceClient.get(id: id, query: query)
    }

    @concurrent
    func create<Body: Encodable & Sendable>(
        body: Body,
        query: SwikiQuery = [:]
    ) async throws -> Model {
        try await resourceClient.create(body: body, query: query)
    }

    @concurrent
    func update<Body: Encodable & Sendable>(
        id: String,
        body: Body,
        query: SwikiQuery = [:],
        method: SwikiHTTPMethod = .put
    ) async throws -> Model {
        try await resourceClient.update(id: id, body: body, query: query, method: method)
    }

    @concurrent
    func delete(id: String, query: SwikiQuery = [:]) async throws {
        try await resourceClient.delete(id: id, query: query)
    }

    @concurrent
    func request<Response: Decodable & Sendable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        route: String? = nil,
        query: SwikiQuery = [:]
    ) async throws -> Response {
        try await resourceClient.request(method, id: id, route: route, query: query)
    }

    @concurrent
    func request<Response: Decodable & Sendable, Body: Encodable & Sendable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        route: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws -> Response {
        try await resourceClient.request(method, id: id, route: route, query: query, body: body)
    }

    @concurrent
    func request(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        route: String? = nil,
        query: SwikiQuery = [:]
    ) async throws {
        try await resourceClient.request(method, id: id, route: route, query: query)
    }

    @concurrent
    func request<Body: Encodable & Sendable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        route: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws {
        try await resourceClient.request(method, id: id, route: route, query: query, body: body)
    }

}
