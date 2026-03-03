import Foundation
import SwikiModels

public struct SwikiV1TopicIgnoresClient: SwikiResourceSubclient {
    public typealias Model = SwikiTopicIgnore
    public let resourceClient: SwikiResourceClient<SwikiTopicIgnore>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "topic_ignores")
    }
}

public extension SwikiV1TopicIgnoresClient {
    func create(topicId: String, query: SwikiQuery = [:]) async throws {
        try await request(.post, id: topicId, query: query)
    }
    func delete(topicId: String, query: SwikiQuery = [:]) async throws {
        try await request(.delete, id: topicId, query: query)
    }
}
