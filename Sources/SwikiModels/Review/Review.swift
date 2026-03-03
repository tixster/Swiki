import Foundation

public struct SwikiReview: Decodable, Sendable {
    public let id: String
    public let userId: String
    public let targetId: String
    public let targetType: String
    public let score: Int
    public let status: String
    public let body: String
    public let htmlBody: String
    public let isPositive: Bool
    public let isNeutral: Bool
    public let isNegative: Bool
    public let createdAt: Date
    public let updatedAt: Date
    public let user: SwikiUser?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case targetId = "target_id"
        case targetType = "target_type"
        case score
        case status
        case body
        case htmlBody = "html_body"
        case isPositive = "is_positive"
        case isNeutral = "is_neutral"
        case isNegative = "is_negative"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.targetId = try container.decodeStringOrInt(forKey: .targetId)
        self.targetType = try container.decode(String.self, forKey: .targetType)
        self.score = try container.decode(Int.self, forKey: .score)
        self.status = try container.decode(String.self, forKey: .status)
        self.body = try container.decode(String.self, forKey: .body)
        self.htmlBody = try container.decode(String.self, forKey: .htmlBody)
        self.isPositive = try container.decode(Bool.self, forKey: .isPositive)
        self.isNeutral = try container.decode(Bool.self, forKey: .isNeutral)
        self.isNegative = try container.decode(Bool.self, forKey: .isNegative)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.user = try container.decodeIfPresent(SwikiUser.self, forKey: .user)
    }
}
