import Foundation

public struct SwikiFavorite: Decodable, Sendable {
    public let id: String
    public let linkedId: String
    public let linkedType: String
    public let kind: String
    public let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case linkedId = "linked_id"
        case linkedType = "linked_type"
        case kind
        case createdAt = "created_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.linkedId = try container.decodeStringOrInt(forKey: .linkedId)
        self.linkedType = try container.decode(String.self, forKey: .linkedType)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
}
