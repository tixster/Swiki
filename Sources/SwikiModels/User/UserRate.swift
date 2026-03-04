import Foundation

public struct SwikiUserRate: Decodable, Sendable {
    public let id: String
    public let userId: String?
    public let episodes: Int?
    public let volumes: Int?
    public let chapters: Int?
    public let rewatches: Int?
    public let status: SwikiUserRateStatus
    public let score: Int
    public let text: String?
    public let textHtml: String?
    public let createdAt: Date?
    public let updatedAt: Date?
    public let targetId: String?
    public let targetType: SwikiUserRateTargetType?

    enum CodingKeysRest: String, CodingKey {
        case id
        case episodes
        case volumes
        case chapters
        case rewatches
        case status
        case score
        case text
        case textHtml = "text_html"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case targetId = "target_id"
        case targetType = "target_type"
    }

    enum CodingKeysGraphQl: String, CodingKey {
        case id
        case episodes
        case volumes
        case chapters
        case rewatches
        case status
        case score
        case text
        case createdAt
        case updatedAt
        case userId
        case targetId
        case targetType
    }

    public init(from decoder: any Decoder) throws {
        let apiType = try decoder.getApiType()
        if apiType == .rest {
            let container = try decoder.container(keyedBy: CodingKeysRest.self)
            self.id = try container.decodeStringOrInt(forKey: .id)
            self.episodes = try container.decodeIfPresent(Int.self, forKey: .episodes)
            self.volumes = try container.decodeIfPresent(Int.self, forKey: .volumes)
            self.chapters = try container.decodeIfPresent(Int.self, forKey: .chapters)
            self.rewatches = try container.decodeIfPresent(Int.self, forKey: .rewatches)
            self.status = try container.decode(SwikiUserRateStatus.self, forKey: .status)
            self.score = try container.decode(Int.self, forKey: .score)
            self.text = try container.decodeIfPresent(String.self, forKey: .text)
            self.textHtml = try container.decodeIfPresent(String.self, forKey: .textHtml)
            self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
            self.userId = try container.decodeStringOrIntIfPresent(forKey: .userId)
            self.targetId = try container.decodeStringOrIntIfPresent(forKey: .targetId)
            self.targetType = try container.decodeIfPresent(SwikiUserRateTargetType.self, forKey: .targetType)
        } else {
            let container = try decoder.container(keyedBy: CodingKeysGraphQl.self)
            self.id = try container.decodeStringOrInt(forKey: .id)
            self.episodes = try container.decodeIfPresent(Int.self, forKey: .episodes)
            self.volumes = try container.decodeIfPresent(Int.self, forKey: .volumes)
            self.chapters = try container.decodeIfPresent(Int.self, forKey: .chapters)
            self.rewatches = try container.decodeIfPresent(Int.self, forKey: .rewatches)
            self.status = try container.decode(SwikiUserRateStatus.self, forKey: .status)
            self.score = try container.decode(Int.self, forKey: .score)
            self.text = try container.decodeIfPresent(String.self, forKey: .text)
            self.textHtml = nil
            self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
            self.userId = try container.decodeStringOrIntIfPresent(forKey: .userId)
            self.targetId = try container.decodeStringOrIntIfPresent(forKey: .targetId)
            self.targetType = try container.decodeIfPresent(SwikiUserRateTargetType.self, forKey: .targetType)
        }
    }

}
