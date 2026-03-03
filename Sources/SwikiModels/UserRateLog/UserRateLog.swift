import Foundation

public struct SwikiUserRateLog: Decodable, Sendable {
    public let id: String
    public let userRateId: String
    public let userId: String
    public let action: String
    public let details: String?
    public let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userRateId = "user_rate_id"
        case userId = "user_id"
        case action
        case details
        case createdAt = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userRateId = try container.decodeStringOrInt(forKey: .userRateId)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.action = try container.decode(String.self, forKey: .action)
        self.details = try container.decodeIfPresent(String.self, forKey: .details)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
}
