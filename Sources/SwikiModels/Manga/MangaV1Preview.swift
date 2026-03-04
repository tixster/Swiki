import Foundation

/// RestV1 preview model for `/api/mangas` list-like responses.
public struct SwikiMangaV1Preview: Decodable, Sendable {
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
    public let roles: [String]?
    public let role: String?

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
        case roles
        case role
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
        self.roles = try container.decodeIfPresent([String].self, forKey: .roles)
        self.role = try container.decodeIfPresent(String.self, forKey: .role)
    }
}
