import Foundation

struct SwikiEpisodeNotificationPayloadBody: Encodable {
    let episodeNotification: SwikiEpisodeNotificationPayload
    let token: String

    enum CodingKeys: String, CodingKey {
        case episodeNotification = "episode_notification"
        case token
    }
}


public struct SwikiEpisodeNotificationPayload: Encodable, Sendable {
    public let animeId: String
    public let episode: Int
    public let airedAt: Date
    public let isFandub: Bool?
    public let isRaw: Bool?
    public let isSubtitles: Bool?
    public let isAnime365: Bool?

    enum CodingKeys: String, CodingKey {
        case animeId = "anime_id"
        case episode
        case airedAt = "aired_at"
        case isRaw = "is_raw"
        case isSubtitles = "is_subtitles"
        case isFandub = "is_fandub"
        case isAnime365 = "is_anime365"
    }

    public init(
        animeId: String,
        episode: Int,
        airedAt: Date,
        isFandub: Bool?,
        isRaw: Bool?,
        isSubtitles: Bool?,
        isAnime365: Bool?
    ) {
        self.animeId = animeId
        self.episode = episode
        self.airedAt = airedAt
        self.isFandub = isFandub
        self.isRaw = isRaw
        self.isSubtitles = isSubtitles
        self.isAnime365 = isAnime365
    }

}
