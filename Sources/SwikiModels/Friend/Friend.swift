import Foundation

public struct SwikiFriend: Decodable, Sendable {
    public let id: String
    public let userId: String
    public let friendId: String
    public let createdAt: Date
    public let user: SwikiUserPreview?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case friendId = "friend_id"
        case createdAt = "created_at"
        case user
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.friendId = try container.decodeStringOrInt(forKey: .friendId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.user = try container.decodeIfPresent(SwikiUserPreview.self, forKey: .user)
    }
}
