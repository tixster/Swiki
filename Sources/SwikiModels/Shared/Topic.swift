import Foundation

public struct SwikiLinked: Decodable, Sendable {
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
    }
}

public struct SwikiExtendedLightTopic: Decodable, Sendable {
    public let id: String
    public let linked: SwikiLinked?
    public let event: String?
    public let createdAt: Date?
    public let episode: Int?
    public let url: URL?

    enum CodingKeys: String, CodingKey {
        case id
        case linked
        case event
        case createdAt = "created_at"
        case episode
        case url
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id) ?? ""
        self.linked = try container.decodeIfPresent(SwikiLinked.self, forKey: .linked)
        self.event = try container.decodeIfPresent(String.self, forKey: .event)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .episode) {
            self.episode = intValue
        } else if
            let stringValue = try? container.decodeIfPresent(String.self, forKey: .episode),
            let intValue = Int(stringValue)
        {
            self.episode = intValue
        } else {
            self.episode = nil
        }
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
    }
}

public struct SwikiTopic: Decodable, Sendable {
    public let id: String
    public let linked: SwikiLinked?
    public let event: String?
    public let createdAt: Date?
    public let episode: Int?
    public let topicTitle: String
    public let body: String
    public let htmlBody: String
    public let htmlFooter: String?
    public let commentsCount: Int
    public let forum: SwikiForum?
    public let user: SwikiUser?
    public let type: String
    public let linkedId: String?
    public let linkedType: String?
    public let viewed: Bool
    public let lastCommentViewed: Bool?
    public let url: URL?
    public let tags: [String]
    public let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case linked
        case event
        case createdAt = "created_at"
        case episode
        case topicTitle = "topic_title"
        case title
        case body
        case htmlBody = "html_body"
        case htmlFooter = "html_footer"
        case commentsCount = "comments_count"
        case forum
        case user
        case type
        case linkedId = "linked_id"
        case linkedType = "linked_type"
        case viewed
        case lastCommentViewed = "last_comment_viewed"
        case url
        case tags
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id) ?? ""
        self.linked = try container.decodeIfPresent(SwikiLinked.self, forKey: .linked)
        self.event = try container.decodeIfPresent(String.self, forKey: .event)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .episode) {
            self.episode = intValue
        } else if
            let stringValue = try? container.decodeIfPresent(String.self, forKey: .episode),
            let intValue = Int(stringValue)
        {
            self.episode = intValue
        } else {
            self.episode = nil
        }
        let topicTitle = try container.decodeIfPresent(String.self, forKey: .topicTitle)
        let legacyTitle = try container.decodeIfPresent(String.self, forKey: .title)
        self.topicTitle = topicTitle ?? legacyTitle ?? ""
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        self.htmlBody = try container.decodeIfPresent(String.self, forKey: .htmlBody) ?? ""
        self.htmlFooter = try container.decodeIfPresent(String.self, forKey: .htmlFooter)
        self.commentsCount = try container.decodeIfPresent(Int.self, forKey: .commentsCount) ?? 0
        self.forum = try container.decodeIfPresent(SwikiForum.self, forKey: .forum)
        self.user = try container.decodeIfPresent(SwikiUser.self, forKey: .user)
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.linkedId = try container.decodeStringOrIntIfPresent(forKey: .linkedId)
        self.linkedType = try container.decodeIfPresent(String.self, forKey: .linkedType)
        self.viewed = try container.decodeIfPresent(Bool.self, forKey: .viewed) ?? false
        if let boolValue = try? container.decodeIfPresent(Bool.self, forKey: .lastCommentViewed) {
            self.lastCommentViewed = boolValue
        } else if let intValue = try? container.decodeIfPresent(Int.self, forKey: .lastCommentViewed) {
            self.lastCommentViewed = intValue == 1
        } else {
            self.lastCommentViewed = nil
        }
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
    }
}
