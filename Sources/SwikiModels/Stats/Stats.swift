import Foundation

public struct SwikiStats: Decodable, Sendable {
    public let statuses: SwikiStatsCategory?
    public let fullStatuses: SwikiStatsCategory?
    public let scores: SwikiStatsValues?
    public let types: SwikiStatsValues?
    public let ratings: SwikiStatsRatings?
    public let hasAnime: Bool?
    public let hasManga: Bool?
    public let genres: [SwikiGenre]?
    public let studios: [SwikiStudio]?
    public let publishers: [SwikiPublisher]?
    public let activity: [SwikiStatsActivity]?

    enum CodingKeys: String, CodingKey {
        case statuses
        case fullStatuses = "full_statuses"
        case scores
        case types
        case ratings
        case hasAnime = "has_anime?"
        case hasManga = "has_manga?"
        case genres
        case studios
        case publishers
        case activity
    }
}

public struct SwikiStatsCategory: Decodable, Sendable {
    public let anime: [SwikiStatsCategoryItem]
    public let manga: [SwikiStatsCategoryItem]
}

public struct SwikiStatsCategoryItem: Decodable, Sendable {
    public let id: String
    public let groupedId: String?
    public let name: String
    public let size: Int?
    public let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case groupedId = "grouped_id"
        case name
        case size
        case type
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.groupedId = try container.decodeIfPresent(String.self, forKey: .groupedId)
        self.name = try container.decode(String.self, forKey: .name)
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }
}

public struct SwikiStatsValues: Decodable, Sendable {
    public let anime: [SwikiStatsValueItem]
    public let manga: [SwikiStatsValueItem]
}

public struct SwikiStatsRatings: Decodable, Sendable {
    public let anime: [SwikiStatsValueItem]
}

public struct SwikiStatsValueItem: Decodable, Sendable {
    public let name: String
    public let value: Int
}

public struct SwikiStatsActivity: Decodable, Sendable {
    public let name: [Int]
    public let value: Int?
}
