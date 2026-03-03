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
