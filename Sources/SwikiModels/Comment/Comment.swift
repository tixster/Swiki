import Foundation

public struct SwikiComment: Decodable, Sendable {
    public let id: String
    public let body: String
    public let htmlBody: String
    public let userId: String
    public let commentableId: String
    public let commentableType: String
    public let isSummary: Bool?
    public let isOfftopic: Bool?
    public let isEditable: Bool?
    public let createdAt: Date
    public let updatedAt: Date
    public let user: SwikiUser?

    enum CodingKeys: String, CodingKey {
        case id
        case body
        case htmlBody = "html_body"
        case userId = "user_id"
        case commentableId = "commentable_id"
        case commentableType = "commentable_type"
        case isSummary = "is_summary"
        case isOfftopic = "is_offtopic"
        case isEditable = "is_editable"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.body = try container.decode(String.self, forKey: .body)
        self.htmlBody = try container.decode(String.self, forKey: .htmlBody)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.commentableId = try container.decodeStringOrInt(forKey: .commentableId)
        self.commentableType = try container.decode(String.self, forKey: .commentableType)
        self.isSummary = try container.decodeIfPresent(Bool.self, forKey: .isSummary)
        self.isOfftopic = try container.decodeIfPresent(Bool.self, forKey: .isOfftopic)
        self.isEditable = try container.decodeIfPresent(Bool.self, forKey: .isEditable)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.user = try container.decodeIfPresent(SwikiUser.self, forKey: .user)
    }
}
