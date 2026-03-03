import Foundation
import SwikiModels

public struct SwikiV1TopicsClient: SwikiResourceSubclient {
    public typealias Model = SwikiTopic
    public let resourceClient: SwikiResourceClient<SwikiTopic>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "topics")
    }
}

public extension SwikiV1TopicsClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiTopic] { try await list(query: query) }
    func updates(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiTopic] {
        try await request(.get, action: "updates", query: query)
    }
    func get(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiTopic { try await resourceClient.get(id: id, query: query) }
    func create<Body: Encodable>(body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiTopic {
        try await resourceClient.create(body: body, query: query)
    }
    func update<Body: Encodable>(id: String, body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiTopic {
        try await resourceClient.update(id: id, body: body, query: query, method: .put)
    }
    func delete(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws { try await resourceClient.delete(id: id, query: query) }
}
