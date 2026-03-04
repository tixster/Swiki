import Foundation
import SwikiModels

public struct SwikiV2TopicIgnoreClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV2TopicIgnoreClient {
    func create(topicId: String) async throws -> SwikiTopicIgnore {
        try await transport.request(version: .v2, method: .post, path: "topics", id: topicId, route: "ignore")
    }

    func delete(topicId: String) async throws -> SwikiTopicIgnore {
        try await transport.request(version: .v2, method: .delete, path: "topics", id: topicId, route: "ignore")
    }
}
