import Foundation

public struct SwikiUserLinked: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage?
    public let url: URL?
    public let kind: String?
    public let score: String?
    public let status: String?
    public let volumes: Int?
    public let chapters: Int?
    public let episodes: Int?
    public let episodesAired: Int?
    public let airedOn: Date?
    public let releasedOn: Date?
    public let topicUrl: URL?
    public let threadId: String?
    public let topicId: String?
    public let type: String?

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
        case episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
        case topicUrl = "topic_url"
        case threadId = "thread_id"
        case topicId = "topic_id"
        case type
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decodeIfPresent(SwikiImage.self, forKey: .image)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.score = try container.decodeIfPresent(String.self, forKey: .score)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.volumes = try container.decodeIfPresent(Int.self, forKey: .volumes)
        self.chapters = try container.decodeIfPresent(Int.self, forKey: .chapters)
        self.episodes = try container.decodeIfPresent(Int.self, forKey: .episodes)
        self.episodesAired = try container.decodeIfPresent(Int.self, forKey: .episodesAired)
        self.airedOn = try container.decodeIfPresent(Date.self, forKey: .airedOn)
        self.releasedOn = try container.decodeIfPresent(Date.self, forKey: .releasedOn)
        self.topicUrl = try container.decodeIfPresent(URL.self, forKey: .topicUrl)
        self.threadId = try container.decodeStringOrIntIfPresent(forKey: .threadId)
        self.topicId = try container.decodeStringOrIntIfPresent(forKey: .topicId)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }
}

public struct SwikiMessage: Decodable, Sendable {
    public let id: String
    public let kind: String
    public let read: Bool
    public let body: String
    public let htmlBody: String
    public let fromId: String?
    public let toId: String?
    public let linkedId: String?
    public let linkedType: String?
    public let linked: SwikiUserLinked?
    public let createdAt: Date
    public let updatedAt: Date?
    public let from: SwikiUser?
    public let to: SwikiUser?

    enum CodingKeys: String, CodingKey {
        case id
        case kind
        case read
        case body
        case htmlBody = "html_body"
        case fromId = "from_id"
        case toId = "to_id"
        case linkedId = "linked_id"
        case linkedType = "linked_type"
        case linked
        case isRead = "is_read"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case from
        case to
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.kind = try container.decode(String.self, forKey: .kind)
        let read = try container.decodeIfPresent(Bool.self, forKey: .read)
        let legacyRead = try container.decodeIfPresent(Bool.self, forKey: .isRead)
        self.read = read ?? legacyRead ?? false
        self.body = try container.decode(String.self, forKey: .body)
        self.htmlBody = try container.decode(String.self, forKey: .htmlBody)
        self.fromId = try container.decodeStringOrIntIfPresent(forKey: .fromId)
        self.toId = try container.decodeStringOrIntIfPresent(forKey: .toId)
        self.linkedId = try container.decodeStringOrIntIfPresent(forKey: .linkedId)
        self.linkedType = try container.decodeIfPresent(String.self, forKey: .linkedType)
        self.linked = try container.decodeIfPresent(SwikiUserLinked.self, forKey: .linked)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.from = try container.decodeIfPresent(SwikiUser.self, forKey: .from)
        self.to = try container.decodeIfPresent(SwikiUser.self, forKey: .to)
    }
}
