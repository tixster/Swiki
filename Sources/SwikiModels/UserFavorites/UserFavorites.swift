import Foundation

public struct SwikiUserFavorites: Decodable, Sendable {
    public let animes: [SwikiFavoriteEntry]
    public let mangas: [SwikiFavoriteEntry]
    public let ranobe: [SwikiFavoriteEntry]
    public let characters: [SwikiFavoriteEntry]
    public let people: [SwikiFavoriteEntry]
    public let mangakas: [SwikiFavoriteEntry]
    public let seyu: [SwikiFavoriteEntry]
    public let producers: [SwikiFavoriteEntry]

    enum CodingKeys: String, CodingKey {
        case animes
        case mangas
        case ranobe
        case characters
        case people
        case mangakas
        case seyu
        case producers
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.animes = try container.decodeIfPresent([SwikiFavoriteEntry].self, forKey: .animes) ?? []
        self.mangas = try container.decodeIfPresent([SwikiFavoriteEntry].self, forKey: .mangas) ?? []
        self.ranobe = try container.decodeIfPresent([SwikiFavoriteEntry].self, forKey: .ranobe) ?? []
        self.characters = try container.decodeIfPresent([SwikiFavoriteEntry].self, forKey: .characters) ?? []
        self.people = try container.decodeIfPresent([SwikiFavoriteEntry].self, forKey: .people) ?? []
        self.mangakas = try container.decodeIfPresent([SwikiFavoriteEntry].self, forKey: .mangakas) ?? []
        self.seyu = try container.decodeIfPresent([SwikiFavoriteEntry].self, forKey: .seyu) ?? []
        self.producers = try container.decodeIfPresent([SwikiFavoriteEntry].self, forKey: .producers) ?? []
    }
}

public struct SwikiFavoriteEntry: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage?
    public let url: String?

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decodeIfPresent(SwikiImage.self, forKey: .image)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
    }
}
