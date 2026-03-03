import Foundation

public struct SwikiPublisher: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let url: URL?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case url
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
    }
}
