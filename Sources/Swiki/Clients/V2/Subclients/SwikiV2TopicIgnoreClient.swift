import Foundation
import SwikiModels

public struct SwikiV2TopicIgnoreClient: SwikiResourceSubclient {
    public typealias Model = SwikiTopicIgnore
    public let resourceClient: SwikiResourceClient<Model>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "topics")
    }
}

public extension SwikiV2TopicIgnoreClient {
    
    /// POST ``/api/v2/topics/:topic_id/ignore``
    ///
    /// Ignore a topic
    ///
    /// - Note: Requires `topics` oauth scope
    @discardableResult
    func ignore(topicId: String) async throws -> SwikiTopicIgnore {
        try await request(.post, id: topicId, route: "ignore")
    }

    /// DELETE ``/api/v2/topics/:topic_id/ignore``
    ///
    /// Unignore a topic
    ///
    /// - Note: Requires `topics` oauth scope
    @discardableResult
    func unignore(topicId: String) async throws -> SwikiTopicIgnore {
        try await request(.delete, id: topicId, route: "ignore")
    }

}
