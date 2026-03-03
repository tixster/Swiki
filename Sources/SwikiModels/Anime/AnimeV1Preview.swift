import Foundation

/// RestV1 preview model for `/api/animes` list-like responses.
public struct SwikiAnimeV1Preview: Decodable, Sendable {
    public let id: Int
    public let name: String
    public let russian: String?
    public let image: SwikiImage
    public let url: URL
    public let kind: SwikiAnimeKind
    public let score: String
    public let status: SwikiAnimeStatus
    public let episodes: Int
    public let episodesAired: Int
    public let airedOn: Date?
    public let releasedOn: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
        case kind
        case score
        case status
        case episodes
        case episodesAired = "episodes_aired"
        case airedOn = "aired_on"
        case releasedOn = "released_on"
    }
}
