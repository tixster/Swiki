import Foundation

public struct SwikiGenre: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let kind: SwikiGenreKind
    public let entryType: SwikiGenreEntryType

    enum CodingKeysRest: String, CodingKey {
        case id
        case name
        case russian
        case kind
        case entryType = "entry_type"
    }

    enum CodingKeysGraphQl: String, CodingKey {
        case id
        case name
        case russian
        case kind
        case entryType
    }

    public init(from decoder: any Decoder) throws {
        let apiType = try decoder.getApiType()
        if apiType == .rest {
            let container = try decoder.container(keyedBy: CodingKeysRest.self)
            self.id = try container.decodeStringOrInt(forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.russian = try container.decode(String.self, forKey: .russian)
            self.kind = try container.decode(SwikiGenreKind.self, forKey: .kind)
            self.entryType = try container.decode(SwikiGenreEntryType.self, forKey: .entryType)
        } else {
            let container = try decoder.container(keyedBy: CodingKeysGraphQl.self)
            self.id = try container.decodeStringOrInt(forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.russian = try container.decode(String.self, forKey: .russian)
            self.kind = try container.decode(SwikiGenreKind.self, forKey: .kind)
            self.entryType = try container.decode(SwikiGenreEntryType.self, forKey: .entryType)
        }
    }

}
