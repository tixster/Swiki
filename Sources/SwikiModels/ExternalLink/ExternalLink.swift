import Foundation

public struct SwikiExternalLink: Decodable, Sendable {
    public let id: String?
    public let kind: SwikiExternalLinkKind
    public let url: URL
    public let source: String?
    public let entryId: String?
    public let entryType: String?
    public let createdAt: Date?
    public let updatedAt: Date?
    public let importedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case kind
        case url
        case source
        case entryId = "entry_id"
        case entryType = "entry_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case importedAt = "imported_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id)
        self.kind = (try? container.decode(SwikiExternalLinkKind.self, forKey: .kind)) ?? .unknown
        self.url = try container.decode(URL.self, forKey: .url)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        self.entryId = try container.decodeStringOrIntIfPresent(forKey: .entryId)
        self.entryType = try container.decodeIfPresent(String.self, forKey: .entryType)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.importedAt = try container.decodeIfPresent(Date.self, forKey: .importedAt)
    }
}
