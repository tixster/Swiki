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
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiMessage] { try await list(query: query) }
    func get(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiMessage { try await resourceClient.get(id: id, query: query) }
    func markRead(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.post, id: id, action: "mark_read", query: query)
    }
    func markRead<Body: Encodable>(query: some SwikiQueryConvertible = [:] as SwikiQuery, body: Body) async throws {
        try await request(.post, action: "mark_read", query: query, body: body)
    }
    func markReadAll(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.post, action: "mark_read_all", query: query)
    }
    func readAll(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.post, action: "read_all", query: query)
    }
    func readAll<Body: Encodable>(query: some SwikiQueryConvertible = [:] as SwikiQuery, body: Body) async throws {
        try await request(.post, action: "read_all", query: query, body: body)
    }
    func deleteAll(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.delete, action: "delete_all", query: query)
    }
    func deleteAll<Body: Encodable>(query: some SwikiQueryConvertible = [:] as SwikiQuery, body: Body) async throws {
        try await request(.delete, action: "delete_all", query: query, body: body)
    }
    func create<Body: Encodable>(body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiMessage {
        try await resourceClient.create(body: body, query: query)
    }
    func update<Body: Encodable>(id: String, body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiMessage {
        try await resourceClient.update(id: id, body: body, query: query, method: .post)
    }
    func delete(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await resourceClient.delete(id: id, query: query)
    }
}
