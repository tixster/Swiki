import Foundation

public struct SwikiSeyu: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage?
    public let url: URL?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decodeIfPresent(SwikiImage.self, forKey: .image)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
    }
}

public struct SwikiCharacter: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage?
    public let url: URL?
    public let altname: String?
    public let japanese: String?
    public let description: String?
    public let descriptionHtml: String?
    public let descriptionSource: String?
    public let favoured: Bool
    public let threadId: String?
    public let topicId: String?
    public let updatedAt: Date?
    public let seyu: [SwikiSeyu]?
    public let animes: [SwikiAnimeV1Preview]?
    public let mangas: [SwikiMangaV1Preview]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
        case altname
        case japanese
        case description
        case descriptionHtml = "description_html"
        case descriptionSource = "description_source"
        case favoured
        case threadId = "thread_id"
        case topicId = "topic_id"
        case updatedAt = "updated_at"
        case seyu
        case animes
        case mangas
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decodeIfPresent(SwikiImage.self, forKey: .image)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.altname = try container.decodeIfPresent(String.self, forKey: .altname)
        self.japanese = try container.decodeIfPresent(String.self, forKey: .japanese)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptionHtml = try container.decodeIfPresent(String.self, forKey: .descriptionHtml)
        self.descriptionSource = try container.decodeIfPresent(String.self, forKey: .descriptionSource)
        self.favoured = try container.decodeIfPresent(Bool.self, forKey: .favoured) ?? false
        self.threadId = try container.decodeStringOrIntIfPresent(forKey: .threadId)
        self.topicId = try container.decodeStringOrIntIfPresent(forKey: .topicId)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.seyu = try container.decodeIfPresent([SwikiSeyu].self, forKey: .seyu)
        self.animes = try container.decodeIfPresent([SwikiAnimeV1Preview].self, forKey: .animes)
        self.mangas = try container.decodeIfPresent([SwikiMangaV1Preview].self, forKey: .mangas)
    }
}
