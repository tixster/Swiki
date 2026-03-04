import Foundation

public struct SwikiComment: Decodable, Sendable {
    public let id: String
    public let commentableId: String
    public let commentableType: SwikiCommentableType
    public let body: String
    public let userId: String
    public let createdAt: Date?
    public let updatedAt: Date?
    public let isSummary: Bool
    public let isOfftopic: Bool
    public let htmlBody: String
    public let canBeEdited: Bool
    public let user: SwikiUserPreview?

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
        case canBeEdited = "can_be_edited"
        case isEditable = "is_editable"
        case htmlBody = "html_body"
        case user
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.commentableId = try container.decodeStringOrInt(forKey: .commentableId)
        self.commentableType = try container.decode(SwikiCommentableType.self, forKey: .commentableType)
        self.body = try container.decode(String.self, forKey: .body)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.isSummary = try container.decodeIfPresent(Bool.self, forKey: .isSummary) ?? false
        self.isOfftopic = try container.decodeIfPresent(Bool.self, forKey: .isOfftopic) ?? false
        self.htmlBody = try container.decodeIfPresent(String.self, forKey: .htmlBody) ?? ""
        let canBeEdited = try container.decodeIfPresent(Bool.self, forKey: .canBeEdited)
        let isEditable = try container.decodeIfPresent(Bool.self, forKey: .isEditable)
        self.canBeEdited = canBeEdited ?? isEditable ?? false
        self.user = try container.decodeIfPresent(SwikiUserPreview.self, forKey: .user)
    }
}
