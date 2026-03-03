import Foundation
import SwikiModels

public struct SwikiV1MessagesClient: SwikiResourceSubclient {
    public typealias Model = SwikiMessage
    public let resourceClient: SwikiResourceClient<SwikiMessage>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "messages")
    }
}

public extension SwikiV1MessagesClient {
    func get(query: SwikiV1MessagesQuery = .init()) async throws -> [SwikiMessage] { try await list(query: query.asSwikiQuery) }
    func get(id: String) async throws -> SwikiMessage { try await resourceClient.get(id: id) }
    func markRead(id: String, query: SwikiV1MessagesQuery = .init()) async throws {
        try await request(.post, id: id, action: "mark_read", query: query.asSwikiQuery)
    }
    func markRead<Body: Encodable>(query: SwikiV1MessagesQuery = .init(), body: Body) async throws {
        try await request(.post, action: "mark_read", query: query.asSwikiQuery, body: body)
    }
    func markReadAll(query: SwikiV1MessagesQuery = .init()) async throws {
        try await request(.post, action: "mark_read_all", query: query.asSwikiQuery)
    }
    func readAll(query: SwikiV1MessagesQuery = .init()) async throws {
        try await request(.post, action: "read_all", query: query.asSwikiQuery)
    }
    func readAll<Body: Encodable>(query: SwikiV1MessagesQuery = .init(), body: Body) async throws {
        try await request(.post, action: "read_all", query: query.asSwikiQuery, body: body)
    }
    func deleteAll(query: SwikiV1MessagesQuery = .init()) async throws {
        try await request(.delete, action: "delete_all", query: query.asSwikiQuery)
    }
    func deleteAll<Body: Encodable>(query: SwikiV1MessagesQuery = .init(), body: Body) async throws {
        try await request(.delete, action: "delete_all", query: query.asSwikiQuery, body: body)
    }
    func create<Body: Encodable>(body: Body, query: SwikiV1MessagesQuery = .init()) async throws -> SwikiMessage {
        try await resourceClient.create(body: body, query: query.asSwikiQuery)
    }
    func update<Body: Encodable>(id: String, body: Body, query: SwikiV1MessagesQuery = .init()) async throws -> SwikiMessage {
        try await resourceClient.update(id: id, body: body, query: query.asSwikiQuery, method: .post)
    }
    func delete(id: String) async throws {
        try await resourceClient.delete(id: id)
    }
}
