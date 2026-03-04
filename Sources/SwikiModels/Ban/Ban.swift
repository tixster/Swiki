import Foundation

public struct SwikiBanComment: Decodable, Sendable {
    public let id: String
    public let commentableId: String
    public let commentableType: String
    public let body: String
    public let userId: String
    public let createdAt: Date?
    public let updatedAt: Date?
    public let isSummary: Bool
    public let isOfftopic: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case commentableId = "commentable_id"
        case commentableType = "commentable_type"
        case body
        case userId = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isSummary = "is_summary"
        case isOfftopic = "is_offtopic"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id) ?? ""
        self.commentableId = try container.decodeStringOrIntIfPresent(forKey: .commentableId) ?? ""
        self.commentableType = try container.decodeIfPresent(String.self, forKey: .commentableType) ?? ""
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        self.userId = try container.decodeStringOrIntIfPresent(forKey: .userId) ?? ""
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.isSummary = try container.decodeIfPresent(Bool.self, forKey: .isSummary) ?? false
        self.isOfftopic = try container.decodeIfPresent(Bool.self, forKey: .isOfftopic) ?? false
    }
}

public struct SwikiBan: Decodable, Sendable {
    public let id: String
    public let userId: String
    public let moderatorId: String
    public let comment: SwikiBanComment?
    public let reason: String
    public let createdAt: Date
    public let durationMinutes: Int
    public let user: SwikiUserPreview?
    public let moderator: SwikiUserPreview?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case moderatorId = "moderator_id"
        case comment
        case reason
        case createdAt = "created_at"
        case durationMinutes = "duration_minutes"
        case user
        case moderator
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.moderatorId = try container.decodeStringOrInt(forKey: .moderatorId)
        self.comment = try container.decodeIfPresent(SwikiBanComment.self, forKey: .comment)
        self.reason = try container.decode(String.self, forKey: .reason)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.durationMinutes = try container.decode(Int.self, forKey: .durationMinutes)
        self.user = try container.decodeIfPresent(SwikiUserPreview.self, forKey: .user)
        self.moderator = try container.decodeIfPresent(SwikiUserPreview.self, forKey: .moderator)
    }
}
