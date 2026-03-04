import Foundation

public struct SwikiPersonPreview: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage
    public let url: URL

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decode(SwikiImage.self, forKey: .image)
        self.url = try container.decode(URL.self, forKey: .url)
    }
}
