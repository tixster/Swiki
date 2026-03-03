import Foundation

public struct SwikiFranchise: Decodable, Sendable {
    public let links: [SwikiFranchiseLink]
    public let nodes: [SwikiFranchiseNode]
}

public struct SwikiFranchiseLink: Decodable, Sendable {
    public let id: String
    public let sourceId: String
    public let targetId: String
    public let weight: Int
    public let relation: String
    public let relationRussian: String

    enum CodingKeys: String, CodingKey {
        case id
        case sourceId = "source_id"
        case targetId = "target_id"
        case weight
        case relation
        case relationRussian = "relation_russian"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.sourceId = try container.decodeStringOrInt(forKey: .sourceId)
        self.targetId = try container.decodeStringOrInt(forKey: .targetId)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.relation = try container.decode(String.self, forKey: .relation)
        self.relationRussian = try container.decode(String.self, forKey: .relationRussian)
    }
}

public struct SwikiFranchiseNode: Decodable, Sendable {
    public let id: String
    public let name: String
    public let imageUrl: String
    public let url: String
    public let kind: String
    public let weight: Int
    public let date: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case url
        case kind
        case weight
        case date
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.url = try container.decode(String.self, forKey: .url)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
    }
}
