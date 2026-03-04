import Foundation
import SwikiModels

struct SwikiUserRatesCreatePayloadBody: Encodable, Sendable {
    let userRate: SwikiUserRatesCreatePayload
    enum CodingKeys: String, CodingKey {
        case userRate = "user_rate"
    }
}

public struct SwikiUserRatesCreatePayload: Encodable, Sendable {
    public let userId: String
    public let targetId: String
    public let targetType: SwikiUserRateTargetType
    public let status: SwikiUserRateStatus?
    public let score: Int?
    public let chapters: Int?
    public let episodes: Int?
    public let volumes: Int?
    public let rewatches: Int?
    public let text: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case targetId = "target_id"
        case targetType = "target_type"
        case status
        case score
        case chapters
        case episodes
        case volumes
        case rewatches
        case text
    }

    public init(
        userId: String,
        targetId: String,
        targetType: SwikiUserRateTargetType,
        status: SwikiUserRateStatus?,
        score: Int?,
        chapters: Int?,
        episodes: Int?,
        volumes: Int?,
        rewatches: Int?,
        text: String?
    ) {
        self.userId = userId
        self.targetId = targetId
        self.targetType = targetType
        self.status = status
        self.score = score
        self.chapters = chapters
        self.episodes = episodes
        self.volumes = volumes
        self.rewatches = rewatches
        self.text = text
    }
}
