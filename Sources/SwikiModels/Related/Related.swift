import Foundation

public struct SwikiRelatedAnime: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage
    public let url: URL
    public let kind: SwikiAnimeKind
    public let score: String
    public let status: SwikiAnimeStatus
    public let episodes: Int
    public let episodesAired: Int
    public let airedOn: Date?
    public let releasedOn: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
        case kind
        case score
        case status
        case episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decode(SwikiImage.self, forKey: .image)
        self.url = try container.decode(URL.self, forKey: .url)
        self.kind = try container.decode(SwikiAnimeKind.self, forKey: .kind)
        self.score = try container.decode(String.self, forKey: .score)
        self.status = try container.decode(SwikiAnimeStatus.self, forKey: .status)
        self.episodes = try container.decode(Int.self, forKey: .episodes)
        self.episodesAired = try container.decode(Int.self, forKey: .episodesAired)
        self.airedOn = try container.decodeIfPresent(Date.self, forKey: .airedOn)
        self.releasedOn = try container.decodeIfPresent(Date.self, forKey: .releasedOn)
    }
}

public struct SwikiRelatedManga: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage
    public let url: URL
    public let kind: SwikiMangaKind
    public let score: String
    public let status: SwikiMangaStatus
    public let volumes: Int
    public let chapters: Int
    public let airedOn: Date?
    public let releasedOn: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
        case kind
        case score
        case status
        case volumes
        case chapters
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decode(SwikiImage.self, forKey: .image)
        self.url = try container.decode(URL.self, forKey: .url)
        self.kind = try container.decode(SwikiMangaKind.self, forKey: .kind)
        self.score = try container.decode(String.self, forKey: .score)
        self.status = try container.decode(SwikiMangaStatus.self, forKey: .status)
        self.volumes = try container.decode(Int.self, forKey: .volumes)
        self.chapters = try container.decode(Int.self, forKey: .chapters)
        self.airedOn = try container.decodeIfPresent(Date.self, forKey: .airedOn)
        self.releasedOn = try container.decodeIfPresent(Date.self, forKey: .releasedOn)
    }
}

public struct SwikiRelated: Decodable, Sendable {
    public let id: String?
    public let relation: SwikiRelationKind
    public let relationRussian: String
    public let anime: SwikiRelatedAnime?
    public let manga: SwikiRelatedManga?

    enum CodingKeys: String, CodingKey {
        case id
        case relation
        case relationRussian = "relation_russian"
        case relationText = "relation_text"
        case anime
        case manga
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id)
        self.relation = try container.decode(SwikiRelationKind.self, forKey: .relation)
        let relationRussian = try container.decodeIfPresent(String.self, forKey: .relationRussian)
        let relationText = try container.decodeIfPresent(String.self, forKey: .relationText)
        self.relationRussian = relationRussian ?? relationText ?? ""
        self.anime = try container.decodeIfPresent(SwikiRelatedAnime.self, forKey: .anime)
        self.manga = try container.decodeIfPresent(SwikiRelatedManga.self, forKey: .manga)
    }
}
