import Foundation
import SwikiModels

struct SwikiUserRatesUpdatePayloadBody: Encodable, Sendable {
    let userRate: SwikiUserRatesUpdatePayload
    enum CodingKeys: String, CodingKey {
        case userRate = "user_rate"
    }
}

public struct SwikiUserRatesUpdatePayload: Encodable, Sendable {
     public let status: SwikiUserRateStatus?
    public let score: Int?
    public let chapters: Int?
    public let episodes: Int?
    public let volumes: Int?
    public let rewatches: Int?
    public let text: String?

    enum CodingKeys: String, CodingKey {
        case status
        case score
        case chapters
        case episodes
        case volumes
        case rewatches
        case text
    }

    public init(
        status: SwikiUserRateStatus?,
        score: Int?,
        chapters: Int?,
        episodes: Int?,
        volumes: Int?,
        rewatches: Int?,
        text: String?
    ) {
        self.status = status
        self.score = score
        self.chapters = chapters
        self.episodes = episodes
        self.volumes = volumes
        self.rewatches = rewatches
        self.text = text
    }
}
