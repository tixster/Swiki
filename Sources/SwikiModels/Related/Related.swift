import Foundation

public struct SwikiRelated: Decodable, Sendable {
    public let id: String?
    public let relation: SwikiRelationKind
    public let relationRussian: String
    public let anime: SwikiAnime?
    public let manga: SwikiManga?

    enum CodingKeys: String, CodingKey {
        case id
        case relation
        case relationRussian = "relation_russian"
        case relationText = "relation_text"
        case anime
        case manga
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id)
        self.relation = (try? container.decode(SwikiRelationKind.self, forKey: .relation)) ?? .other
        let relationRussian = try container.decodeIfPresent(String.self, forKey: .relationRussian)
        let relationText = try container.decodeIfPresent(String.self, forKey: .relationText)
        self.relationRussian = relationRussian ?? relationText ?? ""
        self.anime = try container.decodeIfPresent(SwikiAnime.self, forKey: .anime)
        self.manga = try container.decodeIfPresent(SwikiManga.self, forKey: .manga)
    }
}
