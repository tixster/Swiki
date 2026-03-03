import Foundation

public struct Achievement: Decodable, Sendable {
    public let id: String
    public let nekoId: String
    public let level: Int
    public let progress: Int
    public let userId: String
    public let createdAt: Date
    public let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case nekoId = "neko_id"
        case level
        case progress
        case userId = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.nekoId = try container.decode(String.self, forKey: .nekoId)
        self.level = try container.decode(Int.self, forKey: .level)
        self.progress = try container.decode(Int.self, forKey: .progress)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }

}
