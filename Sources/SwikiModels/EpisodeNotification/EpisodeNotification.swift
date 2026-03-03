import Foundation

public struct SwikiEpisodeNotification: Decodable, Sendable {
    public let id: String?
    public let animeId: String?
    public let episode: Int
    public let isRaw: Bool
    public let isSubtitles: Bool
    public let isFandub: Bool
    public let isAnime365: Bool
    public let topicId: String?

    enum CodingKeys: String, CodingKey {
        case id
        case animeId = "anime_id"
        case episode
        case isRaw = "is_raw"
        case isSubtitles = "is_subtitles"
        case isFandub = "is_fandub"
        case isAnime365 = "is_anime365"
        case topicId = "topic_id"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id)
        self.animeId = try container.decodeStringOrIntIfPresent(forKey: .animeId)
        self.episode = try container.decode(Int.self, forKey: .episode)
        self.isRaw = try container.decode(Bool.self, forKey: .isRaw)
        self.isSubtitles = try container.decode(Bool.self, forKey: .isSubtitles)
        self.isFandub = try container.decode(Bool.self, forKey: .isFandub)
        self.isAnime365 = try container.decode(Bool.self, forKey: .isAnime365)
        self.topicId = try container.decodeStringOrIntIfPresent(forKey: .topicId)
    }
}
