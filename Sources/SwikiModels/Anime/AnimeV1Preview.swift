import Foundation

/// RestV1 preview model for `/api/animes` list-like responses.
public struct SwikiAnimeV1Preview: Decodable, Sendable {
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
