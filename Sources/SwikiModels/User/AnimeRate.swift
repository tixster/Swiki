import Foundation

public struct SwikiAnimeRate: Decodable, Sendable {
    public let id: String
    public let score: Int
    public let status: SwikiUserRateStatus
    public let rewatches: Int?
    public let episodes: Int?
    public let volumes: Int?
    public let chapters: Int?
    public let text: String?
    public let textHtml: String?
    public let createdAt: Date?
    public let updatedAt: Date?
    public let user: SwikiUser?
    public let anime: SwikiAnime?
    public let manga: SwikiManga?

    enum CodingKeys: String, CodingKey {
        case id
        case score
        case status
        case rewatches
        case episodes
        case volumes
        case chapters
        case text
        case textHtml = "text_html"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
        case anime
        case manga
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.score = try container.decode(Int.self, forKey: .score)
        self.status = try container.decode(SwikiUserRateStatus.self, forKey: .status)
        self.rewatches = try container.decodeIfPresent(Int.self, forKey: .rewatches)
        self.episodes = try container.decodeIfPresent(Int.self, forKey: .episodes)
        self.volumes = try container.decodeIfPresent(Int.self, forKey: .volumes)
        self.chapters = try container.decodeIfPresent(Int.self, forKey: .chapters)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.textHtml = try container.decodeIfPresent(String.self, forKey: .textHtml)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.user = try container.decodeIfPresent(SwikiUser.self, forKey: .user)
        self.anime = try container.decodeIfPresent(SwikiAnime.self, forKey: .anime)
        self.manga = try container.decodeIfPresent(SwikiManga.self, forKey: .manga)
    }
}
