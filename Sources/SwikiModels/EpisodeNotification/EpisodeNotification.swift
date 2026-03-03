import Foundation

public struct SwikiEpisodeNotification: Decodable, Sendable {
    public let id: String
    public let userId: String
    public let animeId: String
    public let episode: Int
    public let releasedAt: Date?
    public let createdAt: Date
    public let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case animeId = "anime_id"
        case episode
        case releasedAt = "released_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.animeId = try container.decodeStringOrInt(forKey: .animeId)
        self.episode = try container.decode(Int.self, forKey: .episode)
        self.releasedAt = try container.decodeIfPresent(Date.self, forKey: .releasedAt)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}
