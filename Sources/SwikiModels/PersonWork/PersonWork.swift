import Foundation

public struct SwikiPersonWork: Decodable, Sendable {
    public let anime: SwikiAnime?
    public let manga: SwikiManga?
    public let role: String
    public let roleRussian: String

    enum CodingKeys: String, CodingKey {
        case anime
        case manga
        case role
        case roleRussian = "role_russian"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.anime = try container.decodeIfPresent(SwikiAnime.self, forKey: .anime)
        self.manga = try container.decodeIfPresent(SwikiManga.self, forKey: .manga)
        self.role = try container.decode(String.self, forKey: .role)
        self.roleRussian = try container.decode(String.self, forKey: .roleRussian)
    }
}
