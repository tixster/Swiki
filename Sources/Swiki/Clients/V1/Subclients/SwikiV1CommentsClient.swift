import Foundation
import SwikiModels

public struct SwikiV1CommentsClient: SwikiResourceSubclient {
    public typealias Model = SwikiComment
    public let resourceClient: SwikiResourceClient<SwikiComment>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "comments")
    }
}

public extension SwikiV1CommentsClient {
    func get(query: SwikiV1CommentsQuery = .init()) async throws -> [SwikiComment] { try await list(query: query.asSwikiQuery) }
    func get(id: String) async throws -> SwikiComment { try await resourceClient.get(id: id) }
    func create<Body: Encodable>(body: Body, query: SwikiV1CommentsQuery = .init()) async throws -> SwikiComment {
        try await resourceClient.create(body: body, query: query.asSwikiQuery)
    }
    func update<Body: Encodable>(id: String, body: Body, query: SwikiV1CommentsQuery = .init()) async throws -> SwikiComment {
        try await resourceClient.update(id: id, body: body, query: query.asSwikiQuery, method: .put)
    }
    func delete(id: String) async throws { try await resourceClient.delete(id: id) }
}
