import Foundation

public struct SwikiAppear: Decodable, Sendable {
    public let id: String
    public let kind: String
    public let userId: String
    public let topicId: String?
    public let commentId: String?
    public let isRead: Bool
    public let createdAt: Date
    public let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case kind
        case userId = "user_id"
        case topicId = "topic_id"
        case commentId = "comment_id"
        case isRead = "is_read"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.topicId = try container.decodeStringOrIntIfPresent(forKey: .topicId)
        self.commentId = try container.decodeStringOrIntIfPresent(forKey: .commentId)
        self.isRead = try container.decode(Bool.self, forKey: .isRead)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}
