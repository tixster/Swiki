import Foundation

public struct SwikiIgnore: Decodable, Sendable {
    public let id: String
    public let userId: String
    public let targetId: String
    public let targetType: String
    public let reason: String?
    public let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case targetId = "target_id"
        case targetType = "target_type"
        case reason
        case createdAt = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.targetId = try container.decodeStringOrInt(forKey: .targetId)
        self.targetType = try container.decode(String.self, forKey: .targetType)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
}
