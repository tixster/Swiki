import Foundation

public struct SwikiUserHistory: Decodable, Sendable {
    public let id: String
    public let createdAt: Date
    public let description: String
    public let target: SwikiJSONValue?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case description
        case target
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.description = try container.decode(String.self, forKey: .description)
        self.target = try container.decodeIfPresent(SwikiJSONValue.self, forKey: .target)
    }
}
