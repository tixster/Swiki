import Foundation
import SwikiModels

public struct SwikiV2TopicIgnoreClient: SwikiResourceSubclient {
    public typealias Model = SwikiTopicIgnore
    public let resourceClient: SwikiResourceClient<SwikiTopicIgnore>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "topic_ignore")
    }
}

public extension SwikiV2TopicIgnoreClient {
    func create(topicId: String, query: SwikiQuery = [:]) async throws {
        try await request(.post, id: topicId, query: query)
    }

    func delete(topicId: String, query: SwikiQuery = [:]) async throws {
        try await request(.delete, id: topicId, query: query)
    }
}
