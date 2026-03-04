import Foundation

public struct SwikiMessagePreview: Decodable, Sendable {
    public let id: String
    public let kind: String
    public let read: Bool
    public let body: String
    public let htmlBody: String
    public let linkedId: String?
    public let linkedType: String?
    public let linked: SwikiUserLinked?
    public let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case kind
        case read
        case body
        case htmlBody = "html_body"
        case linkedId = "linked_id"
        case linkedType = "linked_type"
        case linked
        case isRead = "is_read"
        case createdAt = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.kind = try container.decode(String.self, forKey: .kind)
        let read = try container.decodeIfPresent(Bool.self, forKey: .read)
        let legacyRead = try container.decodeIfPresent(Bool.self, forKey: .isRead)
        self.read = read ?? legacyRead ?? false
        self.body = try container.decode(String.self, forKey: .body)
        self.htmlBody = try container.decode(String.self, forKey: .htmlBody)
        self.linkedId = try container.decodeStringOrIntIfPresent(forKey: .linkedId)
        self.linkedType = try container.decodeIfPresent(String.self, forKey: .linkedType)
        self.linked = try container.decodeIfPresent(SwikiUserLinked.self, forKey: .linked)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
}
