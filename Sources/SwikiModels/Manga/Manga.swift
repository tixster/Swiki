import Foundation

public struct SwikiManga: SwikiTitle {
    public let id: String
    public let name: String
    public let russian: String?
    public let licenseNameRu: String?
    public let english: [String]?
    public let japanese: [String]?
    public let synonims: [String]?
    public let kind: SwikiMangaKind
    public let score: Float?
    public let chapters: Int
    public let volumes: Int
    public let status: SwikiMangaStatus
    public let airedOn: SwikiIncompleteDate?
    public let releasedOn: SwikiIncompleteDate?
    public let url: URL
    public let poster: SwikiPoster
    public let licensors: [String]
    public let createdAt: Date
    public let updatedAt: Date
    public let nextEpisodeAt: Date?
    public let isCensored: Bool?
    public let genres: [SwikiGenre]?
    public let externalLinks: [SwikiExternalLink]?
    public let personRoles: [SwikiPersonRole]?
    public let characterRoles: [SwikiCharacterRole]?
    public let franchise: String?
    public let description: String?
    public let descriptionHtml: String?
    public let descriptionSource: String?
    public let videos: [SwikiVideo]
    public let screenshots: [SwikiScreenshot]
    public let opengraphImageUrl: URL?
    public let related: [SwikiRelated]?
    public let scoresStats: [SwikiScoreStat]?
    public let statusesStats: [SwikiUserRateStatus]?
    public let topic: SwikiTopic?
    public let userRate: SwikiUserRate?
}
