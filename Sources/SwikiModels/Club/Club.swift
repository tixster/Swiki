import Foundation

public struct SwikiClub: Decodable, Sendable {
    public let id: String
    public let name: String
    public let logo: SwikiImage
    public let isCensored: Bool
    public let joinPolicy: String
    public let commentPolicy: String
    public let description: String?
    public let descriptionHtml: String?
    public let descriptionSource: String?
    public let isShadowbanned: Bool
    public let userId: String
    public let membersCount: Int
    public let animesCount: Int
    public let createdAt: Date
    public let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
        case isCensored = "is_censored"
        case joinPolicy = "join_policy"
        case commentPolicy = "comment_policy"
        case description
        case descriptionHtml = "description_html"
        case descriptionSource = "description_source"
        case isShadowbanned = "is_shadowbanned"
        case userId = "user_id"
        case membersCount = "members_count"
        case animesCount = "animes_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.logo = try container.decode(SwikiImage.self, forKey: .logo)
        self.isCensored = try container.decode(Bool.self, forKey: .isCensored)
        self.joinPolicy = try container.decode(String.self, forKey: .joinPolicy)
        self.commentPolicy = try container.decode(String.self, forKey: .commentPolicy)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptionHtml = try container.decodeIfPresent(String.self, forKey: .descriptionHtml)
        self.descriptionSource = try container.decodeIfPresent(String.self, forKey: .descriptionSource)
        self.isShadowbanned = try container.decode(Bool.self, forKey: .isShadowbanned)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.membersCount = try container.decode(Int.self, forKey: .membersCount)
        self.animesCount = try container.decode(Int.self, forKey: .animesCount)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}
