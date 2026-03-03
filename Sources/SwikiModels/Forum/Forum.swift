import Foundation

public struct SwikiForum: Decodable, Sendable {
    public let id: String
    public let name: String
    public let url: URL
    public let position: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case position
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(URL.self, forKey: .url)
        self.position = try container.decode(Int.self, forKey: .position)
    }
}
