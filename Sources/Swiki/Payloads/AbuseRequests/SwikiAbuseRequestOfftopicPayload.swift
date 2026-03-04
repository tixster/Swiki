import Foundation

public struct SwikiAbuseRequestOfftopicPayload: Encodable, Sendable {
    public let commentId: String

    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
    }

    public init(commentId: String) {
        self.commentId = commentId
    }
}
