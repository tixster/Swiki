import Foundation

/// GraphQl-модель
public struct SwikiAnime: SwikiTitle {
    public let id: String
    public let malId: String?
    public let name: String
    public let russian: String?
    public let licenseNameRu: String?
    public let english: String?
    public let japanese: String?
    public let synonims: [String]
    public let kind: SwikiAnimeKind
    public let rating: SwikiAnimeRating
    public let score: Float?
    public let status: SwikiAnimeStatus
    public let episodes: Int
    public let episodesAired: Int
    /// Продолжительность в минутах
    public let duration: Int?
    public let airedOn: SwikiIncompleteDate?
    public let releasedOn: SwikiIncompleteDate?
    public let url: URL
    public let season: String?
    public let poster: SwikiPoster
    public let fansubbers: [String]
    public let fandubbers: [String]
    public let licensors: [String]
    public let createdAt: Date
    public let updatedAt: Date
    public let nextEpisodeAt: Date?
    public let isCensored: Bool?
    public let genres: [SwikiGenre]?
    public let studios: [SwikiStudio]
    public let externalLinks: [SwikiExternalLink]?
    public let personRoles: [SwikiPersonRole]?
    public let characterRoles: [SwikiCharacterRole]?
    public let franchise: String?
    public let chronology: [SwikiAnime]?
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

    public init(
        id: String,
        malId: String?,
        name: String,
        russian: String?,
        licenseNameRu: String?,
        english: String?,
        japanese: String?,
        synonims: [String],
        kind: SwikiAnimeKind,
        rating: SwikiAnimeRating,
        score: Float?,
        status: SwikiAnimeStatus,
        episodes: Int,
        episodesAired: Int,
        duration: Int?,
        airedOn: SwikiIncompleteDate?,
        releasedOn: SwikiIncompleteDate?,
        url: URL,
        season: String?,
        poster: SwikiPoster,
        fansubbers: [String],
        fandubbers: [String],
        licensors: [String],
        createdAt: Date,
        updatedAt: Date,
        nextEpisodeAt: Date?,
        isCensored: Bool?,
        genres: [SwikiGenre]?,
        studios: [SwikiStudio],
        externalLinks: [SwikiExternalLink]?,
        personRoles: [SwikiPersonRole]?,
        characterRoles: [SwikiCharacterRole]?,
        franchise: String?,
        chronology: [SwikiAnime]?,
        description: String?,
        descriptionHtml: String?,
        descriptionSource: String?,
        videos: [SwikiVideo],
        screenshots: [SwikiScreenshot],
        opengraphImageUrl: URL?,
        related: [SwikiRelated]?,
        scoresStats: [SwikiScoreStat]?,
        statusesStats: [SwikiUserRateStatus]?,
        topic: SwikiTopic?,
        userRate: SwikiUserRate?
    ) {
        self.id = id
        self.malId = malId
        self.name = name
        self.russian = russian
        self.licenseNameRu = licenseNameRu
        self.english = english
        self.japanese = japanese
        self.synonims = synonims
        self.kind = kind
        self.rating = rating
        self.score = score
        self.status = status
        self.episodes = episodes
        self.episodesAired = episodesAired
        self.duration = duration
        self.airedOn = airedOn
        self.releasedOn = releasedOn
        self.url = url
        self.season = season
        self.poster = poster
        self.fansubbers = fansubbers
        self.fandubbers = fandubbers
        self.licensors = licensors
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.nextEpisodeAt = nextEpisodeAt
        self.isCensored = isCensored
        self.genres = genres
        self.studios = studios
        self.externalLinks = externalLinks
        self.personRoles = personRoles
        self.characterRoles = characterRoles
        self.franchise = franchise
        self.chronology = chronology
        self.description = description
        self.descriptionHtml = descriptionHtml
        self.descriptionSource = descriptionSource
        self.videos = videos
        self.screenshots = screenshots
        self.opengraphImageUrl = opengraphImageUrl
        self.related = related
        self.scoresStats = scoresStats
        self.statusesStats = statusesStats
        self.topic = topic
        self.userRate = userRate
    }
    
}
