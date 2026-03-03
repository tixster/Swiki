import Foundation
import SwikiModels

public struct SwikiV2EpisodeNotificationsClient: Sendable {
    private struct EpisodeNotificationPayload: Encodable {
        let animeId: String
        let episode: Int
        let airedAt: Date
        let isRaw: Bool?
        let isSubtitles: Bool?
        let isFandub: Bool?
        let isAnime365: Bool?

        enum CodingKeys: String, CodingKey {
            case animeId = "anime_id"
            case episode
            case airedAt = "aired_at"
            case isRaw = "is_raw"
            case isSubtitles = "is_subtitles"
            case isFandub = "is_fandub"
            case isAnime365 = "is_anime365"
        }
    }

    private struct CreatePayload: Encodable {
        let episodeNotification: EpisodeNotificationPayload
        let token: String

        enum CodingKeys: String, CodingKey {
            case episodeNotification = "episode_notification"
            case token
        }
    }

    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV2EpisodeNotificationsClient {
    func create<Body: Encodable>(body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiEpisodeNotification {
        try await transport.request(version: .v2, method: .post, path: "episode_notifications", query: query, body: body)
    }

    func create(
        token: String,
        animeId: String,
        episode: Int,
        airedAt: Date,
        isRaw: Bool? = nil,
        isSubtitles: Bool? = nil,
        isFandub: Bool? = nil,
        isAnime365: Bool? = nil,
        query: some SwikiQueryConvertible = [:] as SwikiQuery
    ) async throws -> SwikiEpisodeNotification {
        let payload = CreatePayload(
            episodeNotification: EpisodeNotificationPayload(
                animeId: animeId,
                episode: episode,
                airedAt: airedAt,
                isRaw: isRaw,
                isSubtitles: isSubtitles,
                isFandub: isFandub,
                isAnime365: isAnime365
            ),
            token: token
        )

        return try await create(body: payload, query: query)
    }
}
