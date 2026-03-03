import Foundation

public struct SwikiFranchise: Decodable, Sendable {
    public let links: [SwikiFranchiseLink]
    public let nodes: [SwikiFranchiseNode]
    public let currentId: String?

    enum CodingKeys: String, CodingKey {
        case links
        case nodes
        case currentId = "current_id"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.links = try container.decode([SwikiFranchiseLink].self, forKey: .links)
        self.nodes = try container.decode([SwikiFranchiseNode].self, forKey: .nodes)
        self.currentId = try container.decodeStringOrIntIfPresent(forKey: .currentId)
    }
}

public struct SwikiFranchiseLink: Decodable, Sendable {
    public let id: String
    public let sourceId: String
    public let targetId: String
    public let source: String?
    public let target: String?
    public let weight: Int
    public let relation: SwikiRelationKind
    public let relationRussian: String

    enum CodingKeys: String, CodingKey {
        case id
        case sourceId = "source_id"
        case targetId = "target_id"
        case source
        case target
        case weight
        case relation
        case relationRussian = "relation_russian"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.sourceId = try container.decodeStringOrInt(forKey: .sourceId)
        self.targetId = try container.decodeStringOrInt(forKey: .targetId)
        self.source = try container.decodeStringOrIntIfPresent(forKey: .source)
        self.target = try container.decodeStringOrIntIfPresent(forKey: .target)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.relation = (try? container.decode(SwikiRelationKind.self, forKey: .relation)) ?? .other
        self.relationRussian = try container.decode(String.self, forKey: .relationRussian)
    }
}

public struct SwikiFranchiseNode: Decodable, Sendable {
    public let id: String
    public let name: String
    public let imageUrl: String
    public let url: String
    public let year: Int?
    public let kind: String
    public let weight: Int
    public let date: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case url
        case year
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
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .year) {
            self.year = intValue
        } else if
            let stringValue = try? container.decodeIfPresent(String.self, forKey: .year),
            let intValue = Int(stringValue)
        {
            self.year = intValue
        } else {
            self.year = nil
        }
        self.kind = try container.decode(String.self, forKey: .kind)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.date = try container.decodeIfPresent(Int.self, forKey: .date)
    }
}
