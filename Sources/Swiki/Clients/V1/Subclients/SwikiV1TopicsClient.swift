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
    func get(query: SwikiV1TopicsQuery = .init()) async throws -> [SwikiTopic] { try await list(query: query.asSwikiQuery) }
    func updates(query: SwikiV1TopicsQuery = .init()) async throws -> [SwikiExtendedLightTopic] {
        try await request(.get, action: "updates", query: query.asSwikiQuery)
    }
    func get(id: String, query: SwikiV1TopicsQuery = .init()) async throws -> SwikiTopic { try await resourceClient.get(id: id, query: query.asSwikiQuery) }
    func create<Body: Encodable>(body: Body, query: SwikiV1TopicsQuery = .init()) async throws -> SwikiTopic {
        try await resourceClient.create(body: body, query: query.asSwikiQuery)
    }
    func update<Body: Encodable>(id: String, body: Body, query: SwikiV1TopicsQuery = .init()) async throws -> SwikiTopic {
        try await resourceClient.update(id: id, body: body, query: query.asSwikiQuery, method: .put)
    }
    func delete(id: String, query: SwikiV1TopicsQuery = .init()) async throws { try await resourceClient.delete(id: id, query: query.asSwikiQuery) }
}
