import Foundation
import SwikiModels

public struct SwikiV2EpisodeNotificationsClient: SwikiResourceSubclient {
    public typealias Model = SwikiEpisodeNotification
    public let resourceClient: SwikiResourceClient<Model>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "episode_notifications")
    }

}

public extension SwikiV2EpisodeNotificationsClient {

    /// POST ``/api/v2/episode_notifications``
    /// 
    /// Notify shikimori about anime episode release
    /// 
    /// - Parameters:
    ///    - token: Private token required to access this api
    func create(
        token: String,
        payload: SwikiEpisodeNotificationPayload,
    ) async throws -> SwikiEpisodeNotification {
        try await request(
            .post,
            body: SwikiEpisodeNotificationPayloadBody(
                episodeNotification: payload,
                token: token
            )
        )
    }

}
