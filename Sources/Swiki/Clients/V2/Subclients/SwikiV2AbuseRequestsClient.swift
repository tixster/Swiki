import Foundation
import SwikiModels

public struct SwikiV2AbuseRequestsClient: Sendable {
    private struct OfftopicPayload: Encodable {
        let commentId: String

        enum CodingKeys: String, CodingKey {
            case commentId = "comment_id"
        }
    }

    private struct ActionPayload: Encodable {
        let commentId: String?
        let topicId: String?
        let reason: String?

        enum CodingKeys: String, CodingKey {
            case commentId = "comment_id"
            case topicId = "topic_id"
            case reason
        }
    }

    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV2AbuseRequestsClient {
    func offtopic(commentId: String) async throws -> SwikiAbuseOfftopicResponse {
        try await transport.request(
            version: .v2,
            method: .post,
            path: "abuse_requests",
            action: "offtopic",
            body: OfftopicPayload(commentId: commentId)
        )
    }

    func convertReview(
        commentId: String? = nil,
        topicId: String? = nil
    ) async throws {
        try await transport.request(
            version: .v2,
            method: .post,
            path: "abuse_requests",
            action: "convert_review",
            body: ActionPayload(commentId: commentId, topicId: topicId, reason: nil)
        )
    }

    func review(
        commentId: String? = nil,
        topicId: String? = nil
    ) async throws {
        try await convertReview(commentId: commentId, topicId: topicId)
    }

    func abuse(
        commentId: String? = nil,
        topicId: String? = nil,
        reason: String? = nil
    ) async throws {
        try await transport.request(
            version: .v2,
            method: .post,
            path: "abuse_requests",
            action: "abuse",
            body: ActionPayload(commentId: commentId, topicId: topicId, reason: reason)
        )
    }

    func spoiler(
        commentId: String? = nil,
        topicId: String? = nil,
        reason: String? = nil
    ) async throws {
        try await transport.request(
            version: .v2,
            method: .post,
            path: "abuse_requests",
            action: "spoiler",
            body: ActionPayload(commentId: commentId, topicId: topicId, reason: reason)
        )
    }
}
