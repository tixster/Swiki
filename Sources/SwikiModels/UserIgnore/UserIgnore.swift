import Foundation

public struct SwikiUserIgnore: Decodable, Sendable {
    public let id: String
    public let userId: String
    public let targetUserId: String
    public let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case targetUserId = "target_user_id"
        case createdAt = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.targetUserId = try container.decodeStringOrInt(forKey: .targetUserId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
}
