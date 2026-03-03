import Foundation

public struct SwikiClubImage: Decodable, Sendable {
    public let id: String
    public let originalUrl: URL
    public let mainUrl: URL?
    public let previewUrl: URL?
    public let canDestroy: Bool?
    public let userId: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalUrl = "original_url"
        case mainUrl = "main_url"
        case previewUrl = "preview_url"
        case canDestroy = "can_destroy"
        case userId = "user_id"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.originalUrl = try container.decode(URL.self, forKey: .originalUrl)
        self.mainUrl = try container.decodeIfPresent(URL.self, forKey: .mainUrl)
        self.previewUrl = try container.decodeIfPresent(URL.self, forKey: .previewUrl)
        self.canDestroy = try container.decodeIfPresent(Bool.self, forKey: .canDestroy)
        self.userId = try container.decodeStringOrIntIfPresent(forKey: .userId)
    }
}
