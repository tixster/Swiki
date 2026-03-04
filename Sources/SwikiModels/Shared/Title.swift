import Foundation

public protocol SwikiTitle: Decodable, Sendable {

    associatedtype Kind: Decodable & Sendable
    associatedtype Status: Decodable & Sendable

    var id: String { get }
    var name: String { get }
    var russian: String? { get }
    var licenseNameRu: String? { get }
    var english: [String]? { get }
    var japanese: [String]? { get }
    var synonims: [String]? { get }
    var kind: Kind { get }
    var score: Float? { get }
    var status: Status { get }
    var airedOn: SwikiIncompleteDate? { get }
    var releasedOn: SwikiIncompleteDate? { get }
    var url: URL { get }
    var poster: SwikiPoster { get }
    var licensors: [String] { get }
    var createdAt: Date { get }
    var updatedAt: Date { get }
    var nextEpisodeAt: Date? { get }
    var isCensored: Bool? { get }
    var genres: [SwikiGenre]? { get }
    var externalLinks: [SwikiExternalLink]? { get }
    var personRoles: [SwikiPersonRole]? { get }
    var characterRoles: [SwikiCharacterRole]? { get }
    var franchise: String? { get }
    var description: String? { get }
    var descriptionHtml: String? { get }
    var descriptionSource: String? { get }
    var videos: [SwikiVideo] { get }
    var screenshots: [SwikiScreenshot] { get }
    var opengraphImageUrl: URL? { get }
    var related: [SwikiRelated]? { get }
    var scoresStats: [SwikiScoreStat]? { get }
    var statusesStats: [SwikiUserRateStatus]? { get }
    var topic: SwikiTopic? { get }
    var userRate: SwikiUserRate? { get }
}
