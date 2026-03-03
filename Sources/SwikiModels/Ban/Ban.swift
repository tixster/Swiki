import Foundation

public struct SwikiBan: Decodable, Sendable {
    public let id: String
    public let userId: String
    public let moderatorId: String
    public let reason: String
    public let comment: String?
    public let duration: Int
    public let state: String
    public let createdAt: Date
    public let finishedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case moderatorId = "moderator_id"
        case reason
        case comment
        case duration
        case state
        case createdAt = "created_at"
        case finishedAt = "finished_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.moderatorId = try container.decodeStringOrInt(forKey: .moderatorId)
        self.reason = try container.decode(String.self, forKey: .reason)
        self.comment = try container.decodeIfPresent(String.self, forKey: .comment)
        self.duration = try container.decode(Int.self, forKey: .duration)
        self.state = try container.decode(String.self, forKey: .state)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.finishedAt = try container.decodeIfPresent(Date.self, forKey: .finishedAt)
    }
}
