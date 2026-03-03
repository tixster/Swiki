import Foundation
import SwikiModels

public struct SwikiV2Client: Sendable {
    private let transport: SwikiHTTPTransport
    public let topicIgnore: SwikiV2TopicIgnoreClient
    public let userIgnore: SwikiV2UserIgnoreClient
    public let abuseRequests: SwikiV2AbuseRequestsClient
    public let episodeNotifications: SwikiV2EpisodeNotificationsClient
    public let userRates: SwikiV2UserRatesClient

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
        self.topicIgnore = SwikiV2TopicIgnoreClient(transport: transport)
        self.userIgnore = SwikiV2UserIgnoreClient(transport: transport)
        self.abuseRequests = SwikiV2AbuseRequestsClient(transport: transport)
        self.episodeNotifications = SwikiV2EpisodeNotificationsClient(transport: transport)
        self.userRates = SwikiV2UserRatesClient(transport: transport)
    }
}
