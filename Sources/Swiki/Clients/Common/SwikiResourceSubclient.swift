import Foundation

public struct SwikiResourceClient<Model: Decodable>: Sendable {
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

    public func list(query: SwikiQuery = [:]) async throws -> [Model] {
        try await transport.request(version: version, method: .get, path: path, query: query)
    }

    public func list(query: some SwikiQueryConvertible) async throws -> [Model] {
        try await list(query: query.asSwikiQuery)
    }

    public func get(id: String, query: SwikiQuery = [:]) async throws -> Model {
        try await transport.request(version: version, method: .get, path: path, id: id, query: query)
    }

    public func get(id: String, query: some SwikiQueryConvertible) async throws -> Model {
        try await get(id: id, query: query.asSwikiQuery)
    }

    public func create<Body: Encodable>(
        body: Body,
        query: SwikiQuery = [:]
    ) async throws -> Model {
        try await transport.request(version: version, method: .post, path: path, query: query, body: body)
    }

    public func create<Body: Encodable>(
        body: Body,
        query: some SwikiQueryConvertible
    ) async throws -> Model {
        try await create(body: body, query: query.asSwikiQuery)
    }

    public func update<Body: Encodable>(
        id: String,
        body: Body,
        query: SwikiQuery = [:],
        method: SwikiHTTPMethod = .put
    ) async throws -> Model {
        try await transport.request(version: version, method: method, path: path, id: id, query: query, body: body)
    }

    public func update<Body: Encodable>(
        id: String,
        body: Body,
        query: some SwikiQueryConvertible,
        method: SwikiHTTPMethod = .put
    ) async throws -> Model {
        try await update(
            id: id,
            body: body,
            query: query.asSwikiQuery,
            method: method
        )
    }

    public func delete(id: String, query: SwikiQuery = [:]) async throws {
        try await transport.request(version: version, method: .delete, path: path, id: id, query: query)
    }

    public func delete(id: String, query: some SwikiQueryConvertible) async throws {
        try await delete(id: id, query: query.asSwikiQuery)
    }

    public func request<Response: Decodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:]
    ) async throws -> Response {
        try await transport.request(
            version: version,
            method: method,
            path: path,
            id: id,
            action: action,
            query: query
        )
    }

    public func request<Response: Decodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: some SwikiQueryConvertible
    ) async throws -> Response {
        try await request(
            method,
            id: id,
            action: action,
            query: query.asSwikiQuery
        )
    }

    public func request<Response: Decodable, Body: Encodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws -> Response {
        try await transport.request(
            version: version,
            method: method,
            path: path,
            id: id,
            action: action,
            query: query,
            body: body
        )
    }

    public func request<Response: Decodable, Body: Encodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: some SwikiQueryConvertible,
        body: Body
    ) async throws -> Response {
        try await request(
            method,
            id: id,
            action: action,
            query: query.asSwikiQuery,
            body: body
        )
    }

    public func request(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:]
    ) async throws {
        try await transport.request(
            version: version,
            method: method,
            path: path,
            id: id,
            action: action,
            query: query
        )
    }

    public func request(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: some SwikiQueryConvertible
    ) async throws {
        try await request(
            method,
            id: id,
            action: action,
            query: query.asSwikiQuery
        )
    }

    public func request<Body: Encodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws {
        try await transport.request(
            version: version,
            method: method,
            path: path,
            id: id,
            action: action,
            query: query,
            body: body
        )
    }

    public func request<Body: Encodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: some SwikiQueryConvertible,
        body: Body
    ) async throws {
        try await request(
            method,
            id: id,
            action: action,
            query: query.asSwikiQuery,
            body: body
        )
    }
}

public protocol SwikiResourceSubclient: Sendable {
    associatedtype Model: Decodable
    var resourceClient: SwikiResourceClient<Model> { get }
}

public extension SwikiResourceSubclient {
    func list(query: SwikiQuery = [:]) async throws -> [Model] {
        try await resourceClient.list(query: query)
    }

    func list(query: some SwikiQueryConvertible) async throws -> [Model] {
        try await resourceClient.list(query: query)
    }

    func get(id: String, query: SwikiQuery = [:]) async throws -> Model {
        try await resourceClient.get(id: id, query: query)
    }

    func get(id: String, query: some SwikiQueryConvertible) async throws -> Model {
        try await resourceClient.get(id: id, query: query)
    }

    func create<Body: Encodable>(
        body: Body,
        query: SwikiQuery = [:]
    ) async throws -> Model {
        try await resourceClient.create(body: body, query: query)
    }

    func create<Body: Encodable>(
        body: Body,
        query: some SwikiQueryConvertible
    ) async throws -> Model {
        try await resourceClient.create(body: body, query: query)
    }

    func update<Body: Encodable>(
        id: String,
        body: Body,
        query: SwikiQuery = [:],
        method: SwikiHTTPMethod = .put
    ) async throws -> Model {
        try await resourceClient.update(id: id, body: body, query: query, method: method)
    }

    func update<Body: Encodable>(
        id: String,
        body: Body,
        query: some SwikiQueryConvertible,
        method: SwikiHTTPMethod = .put
    ) async throws -> Model {
        try await resourceClient.update(id: id, body: body, query: query, method: method)
    }

    func delete(id: String, query: SwikiQuery = [:]) async throws {
        try await resourceClient.delete(id: id, query: query)
    }

    func delete(id: String, query: some SwikiQueryConvertible) async throws {
        try await resourceClient.delete(id: id, query: query)
    }

    func request<Response: Decodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:]
    ) async throws -> Response {
        try await resourceClient.request(method, id: id, action: action, query: query)
    }

    func request<Response: Decodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: some SwikiQueryConvertible
    ) async throws -> Response {
        try await resourceClient.request(method, id: id, action: action, query: query)
    }

    func request<Response: Decodable, Body: Encodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws -> Response {
        try await resourceClient.request(method, id: id, action: action, query: query, body: body)
    }

    func request<Response: Decodable, Body: Encodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: some SwikiQueryConvertible,
        body: Body
    ) async throws -> Response {
        try await resourceClient.request(method, id: id, action: action, query: query, body: body)
    }

    func request(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:]
    ) async throws {
        try await resourceClient.request(method, id: id, action: action, query: query)
    }

    func request(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: some SwikiQueryConvertible
    ) async throws {
        try await resourceClient.request(method, id: id, action: action, query: query)
    }

    func request<Body: Encodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: SwikiQuery = [:],
        body: Body
    ) async throws {
        try await resourceClient.request(method, id: id, action: action, query: query, body: body)
    }

    func request<Body: Encodable>(
        _ method: SwikiHTTPMethod,
        id: String? = nil,
        action: String? = nil,
        query: some SwikiQueryConvertible,
        body: Body
    ) async throws {
        try await resourceClient.request(method, id: id, action: action, query: query, body: body)
    }
}
