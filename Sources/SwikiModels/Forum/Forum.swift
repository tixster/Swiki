import Foundation

public struct SwikiForum: Decodable, Sendable {
    public let id: String
    public let position: Int
    public let name: String
    public let permalink: String?
    public let url: URL

    enum CodingKeys: String, CodingKey {
        case id
        case position
        case name
        case permalink
        case url
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.position = try container.decode(Int.self, forKey: .position)
        self.name = try container.decode(String.self, forKey: .name)
        self.permalink = try container.decodeIfPresent(String.self, forKey: .permalink)
        self.url = try container.decode(URL.self, forKey: .url)
    }
}
