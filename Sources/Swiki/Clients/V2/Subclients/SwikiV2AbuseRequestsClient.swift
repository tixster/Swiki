import Foundation
import SwikiModels

public struct SwikiV2AbuseRequestsClient: SwikiResourceSubclient {

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

    public typealias Model = SwikiAbuseOfftopicResponse
    public let resourceClient: SwikiResourceClient<Model>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "abuse_requests")
    }

}

public extension SwikiV2AbuseRequestsClient {

    /// POST ``/api/v2/abuse_requests/offtopic``
    ///
    /// Mark a comment as offtopic. Request will be sent to moderators.
    func offtopic(comment: SwikiAbuseRequestOfftopicPayload) async throws -> SwikiAbuseOfftopicResponse {
        try await request(.post, route: "offtopic", body: comment)
    }

    /// POST ``/api/v2/abuse_requests/review``
    ///
    /// Convert comment to review. Request will be sent to moderators.
    func review(
        comment: SwikiAbuseRequestReviewPayload
    ) async throws {
        try await request(.post, route: "review", body: comment)
    }

    /// POST ``/api/v2/abuse_requests/abuse``
    ///
    /// Create abuse about violation of site rules. Request will be sent to moderators.
    func abuse(
        payload: SwikiAbuseRequestAbusePayload
    ) async throws {
        try await request(.post, route: "abuse", body: payload)
    }

    /// POST ``/api/v2/abuse_requests/spoiler``
    ///
    ///  Create abuse about spoiler in content. Request will be sent to moderators.
    func spoiler(
        payload: SwikiAbuseRequestSpoilerPayload
    ) async throws {
        try await request(.post, route: "spoiler", body: payload)
    }
    
}
