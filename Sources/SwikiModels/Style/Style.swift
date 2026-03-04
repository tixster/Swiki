import Foundation

public struct SwikiStyle: Decodable, Sendable {
    public let id: String
    public let ownerId: String
    public let ownerType: SwikiStyleOwnerType?
    public let name: String
    public let css: String
    public let compiledCss: String?
    public let createdAt: Date?
    public let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case ownerType = "owner_type"
        case name
        case css
        case compiledCss = "compiled_css"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.ownerId = try container.decodeStringOrInt(forKey: .ownerId)
        self.ownerType = try container.decodeIfPresent(SwikiStyleOwnerType.self, forKey: .ownerType)
        self.name = try container.decode(String.self, forKey: .name)
        self.css = try container.decode(String.self, forKey: .css)
        self.compiledCss = try container.decodeIfPresent(String.self, forKey: .compiledCss)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
    }
}
