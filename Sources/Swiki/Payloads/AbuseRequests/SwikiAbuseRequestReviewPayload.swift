import Foundation

public struct SwikiAbuseRequestReviewPayload: Encodable, Sendable {
    public let commentId: String?
    public let topicId: String?

    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case topicId = "topic_id"
    }

    public init(commentId: String?, topicId: String?) {
        self.commentId = commentId
        self.topicId = topicId
    }

}
