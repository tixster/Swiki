import Foundation

public struct SwikiClub: Decodable, Sendable {
    public let id: String
    public let name: String
    public let logo: SwikiClubLogo
    public let isCensored: Bool?
    public let joinPolicy: SwikiClubJoinPolicy
    public let commentPolicy: SwikiClubCommentPolicy
    public let description: String?
    public let descriptionHtml: String?
    public let characters: [SwikiCharacterPreview]?
    public let threadId: String?
    public let topicId: String?
    public let userRole: SwikiClubUserRole?
    public let styleId: String?
    public let members: [SwikiUser]?
    public let animes: [SwikiAnimeV1Preview]?
    public let mangas: [SwikiMangaV1Preview]?
    public let images: [SwikiClubImage]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
        case isCensored = "is_censored"
        case joinPolicy = "join_policy"
        case commentPolicy = "comment_policy"
        case description
        case descriptionHtml = "description_html"
        case mangas
        case characters
        case threadId = "thread_id"
        case topicId = "topic_id"
        case userRole = "user_role"
        case styleId = "style_id"
        case members
        case animes
        case images
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.logo = try container.decode(SwikiClubLogo.self, forKey: .logo)
        self.isCensored = try container.decodeIfPresent(Bool.self, forKey: .isCensored)
        self.joinPolicy = try container.decode(SwikiClubJoinPolicy.self, forKey: .joinPolicy)
        self.commentPolicy = try container.decode(SwikiClubCommentPolicy.self, forKey: .commentPolicy)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptionHtml = try container.decodeIfPresent(String.self, forKey: .descriptionHtml)
        self.characters = try container.decodeIfPresent([SwikiCharacterPreview].self, forKey: .characters)
        self.threadId = try container.decodeStringOrIntIfPresent(forKey: .threadId)
        self.topicId = try container.decodeStringOrIntIfPresent(forKey: .topicId)
        if let role = try? container.decodeIfPresent(SwikiClubUserRole.self, forKey: .userRole) {
            self.userRole = role
        } else if
            let roleRaw = try? container.decodeIfPresent(String.self, forKey: .userRole),
            let role = SwikiClubUserRole(rawValue: roleRaw.lowercased())
        {
            self.userRole = role
        } else {
            self.userRole = nil
        }
        self.styleId = try container.decodeStringOrIntIfPresent(forKey: .styleId)
        self.members = try container.decodeIfPresent([SwikiUser].self, forKey: .members)
        self.animes = try container.decodeIfPresent([SwikiAnimeV1Preview].self, forKey: .animes)
        self.mangas = try container.decodeIfPresent([SwikiMangaV1Preview].self, forKey: .mangas)
        self.images = try container.decodeIfPresent([SwikiClubImage].self, forKey: .images)
    }
}
