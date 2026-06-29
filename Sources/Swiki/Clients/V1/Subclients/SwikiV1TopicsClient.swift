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

    /// GET ``/api/topics``
    ///
    /// List topics.
    @concurrent
    func list(query: SwikiV1TopicsSearchQuery = .init()) async throws -> [SwikiTopic] {
        try await resourceClient.list(query: query.asSwikiQuery)
    }

    /// GET ``/api/topics/updates``
    ///
    /// NewsTopics about database updates
    @concurrent
    func news(query: SwikiV1TopicsQuery = .init()) async throws -> [SwikiTopic] {
        try await request(.get, route: "updates", query: query.asSwikiQuery)
    }

    // GET ``/api/topics/hot``
    ///
    /// Hot topics
    @concurrent
    func hot(query: SwikiV1TopicsHotQuery = .init()) async throws -> [SwikiTopic] {
        try await request(.get, route: "hot", query: query.asSwikiQuery)
    }

    /// GET ``/api/topics/:id``
    ///
    /// Show a topic.
    @concurrent
    func topic(id: String) async throws -> SwikiTopic {
        try await resourceClient.get(id: id)
    }

    /// POST ``/api/topics``
    ///
    /// Create a topic.
    ///
    /// - Note: Requires ``topics`` oauth scope
    @concurrent
    @discardableResult
    func create(topic: SwikiTopicCreatePayload) async throws -> SwikiTopic {
        try await resourceClient.create(body: SwikiTopicCreatePayloadBody(topic: topic))
    }

    /// PUT ``/api/topics/:id``
    ///
    /// Update a topic.
    ///
    /// - Note: Requires ``topics`` oauth scope
    @concurrent
    @discardableResult
    func update(id: String, topic: SwikiTopicUpdatePayload) async throws -> SwikiTopic {
        try await resourceClient.update(
            id: id,
            body: SwikiTopicUpdatePayloadBody(topic: topic),
            method: .put
        )
    }

    /// DELETE ``/api/topics/:id``
    ///
    /// Delete a topic.
    ///
    /// - Note: Requires ``topics`` oauth scope
    @concurrent
    func delete(id: String) async throws {
        try await resourceClient.delete(id: id)
    }

}
