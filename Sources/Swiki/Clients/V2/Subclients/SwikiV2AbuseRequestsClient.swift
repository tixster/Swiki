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
    /// POST ``/api/v2/abuse_requests/offtopic``
    ///
    /// Mark a comment as offtopic.
    func offtopic(commentId: String) async throws -> SwikiAbuseOfftopicResponse {
        try await transport.request(
            version: .v2,
            method: .post,
            path: "abuse_requests",
            route: "offtopic",
            body: OfftopicPayload(commentId: commentId)
        )
    }

    /// POST ``/api/v2/abuse_requests/convert_review``
    ///
    /// Convert comment/topic to review.
    func convertReview(
        commentId: String? = nil,
        topicId: String? = nil
    ) async throws {
        try await transport.request(
            version: .v2,
            method: .post,
            path: "abuse_requests",
            route: "convert_review",
            body: ActionPayload(commentId: commentId, topicId: topicId, reason: nil)
        )
    }

    /// POST ``/api/v2/abuse_requests/convert_review``
    ///
    /// Alias for ``convertReview(commentId:topicId:)``.
    func review(
        commentId: String? = nil,
        topicId: String? = nil
    ) async throws {
        try await convertReview(commentId: commentId, topicId: topicId)
    }

    /// POST ``/api/v2/abuse_requests/abuse``
    ///
    /// Create abuse request.
    func abuse(
        commentId: String? = nil,
        topicId: String? = nil,
        reason: String? = nil
    ) async throws {
        try await transport.request(
            version: .v2,
            method: .post,
            path: "abuse_requests",
            route: "abuse",
            body: ActionPayload(commentId: commentId, topicId: topicId, reason: reason)
        )
    }

    /// POST ``/api/v2/abuse_requests/spoiler``
    ///
    /// Create spoiler request.
    func spoiler(
        commentId: String? = nil,
        topicId: String? = nil,
        reason: String? = nil
    ) async throws {
        try await transport.request(
            version: .v2,
            method: .post,
            path: "abuse_requests",
            route: "spoiler",
            body: ActionPayload(commentId: commentId, topicId: topicId, reason: reason)
        )
    }
}
