import Foundation

public struct SwikiUserImage: Decodable, Sendable {
    public let id: String
    public let userId: String
    public let originalUrl: URL
    public let previewUrl: URL
    public let createdAt: Date
    public let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case originalUrl = "original_url"
        case previewUrl = "preview_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.originalUrl = try container.decode(URL.self, forKey: .originalUrl)
        self.previewUrl = try container.decode(URL.self, forKey: .previewUrl)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}
