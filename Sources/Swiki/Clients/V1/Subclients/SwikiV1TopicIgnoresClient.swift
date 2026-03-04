import Foundation
import SwikiModels

public struct SwikiV1TopicIgnoresClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1TopicIgnoresClient {
    private struct CreateTopicIgnorePayload: Encodable, Sendable {
        let topicIgnore: TopicIgnorePayload

        enum CodingKeys: String, CodingKey {
            case topicIgnore = "topic_ignore"
        }
    }

    private struct TopicIgnorePayload: Encodable, Sendable {
        let topicId: String
        let userId: String?

        enum CodingKeys: String, CodingKey {
            case topicId = "topic_id"
            case userId = "user_id"
        }
    }

    /// POST ``/api/topic_ignores``
    ///
    /// Create a topic ignore.
    ///
    /// - Note: Requires ``topics`` oauth scope
    @available(*, deprecated, message: "API DEPREACATED")
    @discardableResult
    func create(
        topicId: String,
        userId: String? = nil
    ) async throws -> SwikiTopicIgnoreCreateResponse {
        let payload = CreateTopicIgnorePayload(topicIgnore: TopicIgnorePayload(topicId: topicId, userId: userId))
        return try await transport.request(
            version: .v1,
            method: .post,
            path: "topic_ignores",
            body: payload
        )
    }

    /// DELETE ``/api/topic_ignores/:id``
    ///
    /// Delete a topic ignore.
    ///
    /// - Note: Requires ``topics`` oauth scope
    @available(*, deprecated, message: "API DEPREACATED")
    @discardableResult
    func delete(id: String) async throws -> SwikiTopicIgnoreDeleteResponse {
        try await transport.request(version: .v1, method: .delete, path: "topic_ignores", id: id)
    }
    
}
