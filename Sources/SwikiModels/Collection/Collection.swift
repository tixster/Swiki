import Foundation

public struct SwikiCollection: Decodable, Sendable {
    public let id: String
    public let topicTitle: String
    public let body: String
    public let htmlBody: String
    public let htmlFooter: String?
    public let createdAt: Date?
    public let commentsCount: Int
    public let forum: SwikiForum?
    public let user: SwikiUserPreview?
    public let type: String
    public let linkedId: String?
    public let linkedType: String?
    public let linked: SwikiLinked?
    public let viewed: Bool
    public let lastCommentViewed: Bool?
    public let event: String?
    public let episode: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case topicTitle = "topic_title"
        case title
        case body
        case htmlBody = "html_body"
        case htmlFooter = "html_footer"
        case createdAt = "created_at"
        case commentsCount = "comments_count"
        case forum
        case user
        case type
        case linkedId = "linked_id"
        case linkedType = "linked_type"
        case linked
        case viewed
        case lastCommentViewed = "last_comment_viewed"
        case event
        case episode
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        let topicTitle = try container.decodeIfPresent(String.self, forKey: .topicTitle)
        let legacyTitle = try container.decodeIfPresent(String.self, forKey: .title)
        self.topicTitle = topicTitle ?? legacyTitle ?? ""
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        self.htmlBody = try container.decodeIfPresent(String.self, forKey: .htmlBody) ?? ""
        self.htmlFooter = try container.decodeIfPresent(String.self, forKey: .htmlFooter)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.commentsCount = try container.decodeIfPresent(Int.self, forKey: .commentsCount) ?? 0
        self.forum = try container.decodeIfPresent(SwikiForum.self, forKey: .forum)
        self.user = try container.decodeIfPresent(SwikiUserPreview.self, forKey: .user)
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.linkedId = try container.decodeStringOrIntIfPresent(forKey: .linkedId)
        self.linkedType = try container.decodeIfPresent(String.self, forKey: .linkedType)
        self.linked = try container.decodeIfPresent(SwikiLinked.self, forKey: .linked)
        self.viewed = try container.decodeIfPresent(Bool.self, forKey: .viewed) ?? false
        if let boolValue = try? container.decodeIfPresent(Bool.self, forKey: .lastCommentViewed) {
            self.lastCommentViewed = boolValue
        } else if let intValue = try? container.decodeIfPresent(Int.self, forKey: .lastCommentViewed) {
            self.lastCommentViewed = intValue == 1
        } else {
            self.lastCommentViewed = nil
        }
        self.event = try container.decodeIfPresent(String.self, forKey: .event)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .episode) {
            self.episode = intValue
        } else if
            let stringValue = try? container.decodeIfPresent(String.self, forKey: .episode),
            let intValue = Int(stringValue)
        {
            self.episode = intValue
        } else {
            self.episode = nil
        }
    }
}
