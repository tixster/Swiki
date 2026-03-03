import Foundation

public struct SwikiStyle: Decodable, Sendable {
    public let id: String
    public let name: String
    public let description: String?
    public let css: String
    public let ownerId: String
    public let stylableId: String
    public let stylableType: String
    public let createdAt: Date
    public let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case css
        case ownerId = "owner_id"
        case stylableId = "stylable_id"
        case stylableType = "stylable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.css = try container.decode(String.self, forKey: .css)
        self.ownerId = try container.decodeStringOrInt(forKey: .ownerId)
        self.stylableId = try container.decodeStringOrInt(forKey: .stylableId)
        self.stylableType = try container.decode(String.self, forKey: .stylableType)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}
