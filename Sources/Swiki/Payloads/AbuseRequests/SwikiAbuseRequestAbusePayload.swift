import Foundation

public struct SwikiAbuseRequestAbusePayload: Encodable, Sendable {
    public let commentId: String?
    public let topicId: String?
    public let reason: String?

    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case topicId = "topic_id"
        case reason
    }

    public init(
        commentId: String?,
        topicId: String?,
        reason: String?
    ) {
        self.commentId = commentId
        self.topicId = topicId
        self.reason = reason
    }

}
