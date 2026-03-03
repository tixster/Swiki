import Foundation

public struct SwikiMessage: Decodable, Sendable {
    public let id: String
    public let kind: String
    public let body: String
    public let htmlBody: String
    public let fromId: String
    public let toId: String
    public let linkedId: String?
    public let linkedType: String?
    public let isRead: Bool
    public let createdAt: Date
    public let updatedAt: Date
    public let from: SwikiUser?
    public let to: SwikiUser?

    enum CodingKeys: String, CodingKey {
        case id
        case kind
        case body
        case htmlBody = "html_body"
        case fromId = "from_id"
        case toId = "to_id"
        case linkedId = "linked_id"
        case linkedType = "linked_type"
        case isRead = "is_read"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case from
        case to
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.body = try container.decode(String.self, forKey: .body)
        self.htmlBody = try container.decode(String.self, forKey: .htmlBody)
        self.fromId = try container.decodeStringOrInt(forKey: .fromId)
        self.toId = try container.decodeStringOrInt(forKey: .toId)
        self.linkedId = try container.decodeStringOrIntIfPresent(forKey: .linkedId)
        self.linkedType = try container.decodeIfPresent(String.self, forKey: .linkedType)
        self.isRead = try container.decode(Bool.self, forKey: .isRead)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.from = try container.decodeIfPresent(SwikiUser.self, forKey: .from)
        self.to = try container.decodeIfPresent(SwikiUser.self, forKey: .to)
    }
}
