import Foundation
import SwikiModels

/// GET /api/animes
public struct SwikiV1AnimesQuery: SwikiQueryConvertible {
    public typealias Filter<Value: RawRepresentable & Sendable> = SwikiQueryFilter<Value> where Value.RawValue == String

    /// Must be a number between 1 and 100000.
    public var page: Int?
    /// 50 maximum.
    public var limit: Int?
    public var order: SwikiOrder?
    /// - warning: API DEPRECATED
    public var type: String?
    public var season: SwikiSeason?
    /// Supports grouped/subtraction/combined modes:
    /// - include: `tv,movie`
    /// - exclude: `!tv,!movie`
    /// - mixed: `tv,!movie`
    public var kindFilters: [SwikiQueryFilter<SwikiAnimeKind>]
    /// Supports grouped/subtraction/combined modes for status values.
    public var statusFilters: [SwikiQueryFilter<SwikiAnimeStatus>]
    /// Supports grouped/subtraction/combined modes:
    /// - include: `2016,2015`
    /// - exclude: `!2016,!2015`
    /// - mixed: `2016,!summer_2016`
    public var seasonFilters: [SwikiQueryFilter<SwikiSeason>]
    /// Minimal anime score
    public var score: Int?
    public var duration: SwikiAnimeDuration?
    public var rating: SwikiAnimeRating?
    /// List of genre ids separated by comma
    public var genre: [Int]
    // List of genre v2 ids separated by comma
    public var genreV2: [Int]
    /// List of studio ids separated by comma
    public var studio: [Int]
    /// List of franchises separated by comma
    public var franchise: [Int]
    /// Set to false to allow hentai, yaoi and yuri
    public var censored: Bool?
    /// Status of anime in current user list
    public var mylist: SwikiUserRateStatus?
    /// List of anime ids separated by comma
    public var ids: [Int]
    /// List of anime ids separated by comma
    public var excludeIDs: [Int]
    /// Search phrase to filter animes by name
    public var search: String?
    public var extra: SwikiQuery

    /// GET /api/animes 
    /// - Parameters:
    ///   - page: Must be a number between 1 and 100000.
    ///   - limit: 50 maximum.
    ///   - order: order type
    ///   - type: API Deprecated
    ///   - season: Season
    ///   - kindFilters: kindFilters
    ///   - statusFilters: statusFilters
    ///   - seasonFilters: seasonFilters
    ///   - score: Minimal anime score
    ///   - duration: duration
    ///   - rating: rating
    ///   - genre: List of genre ids separated by comma
    ///   - genreV2: List of genre v2 ids separated by comma
    ///   - studio: List of studio ids separated by comma
    ///   - franchise: List of franchises separated by comma
    ///   - censored: Set to false to allow hentai, yaoi and yuri
    ///   - mylist: Status of anime in current user list
    ///   - ids: List of anime ids separated by comma
    ///   - excludeIDs: List of anime ids separated by comma
    ///   - search: Search phrase to filter animes by name
    ///   - extra: extra fields
    public init(
        page: Int? = nil,
        limit: Int? = nil,
        order: SwikiOrder? = nil,
        type: String? = nil,
        season: SwikiSeason? = nil,
        kindFilters: [SwikiQueryFilter<SwikiAnimeKind>] = [],
        statusFilters: [SwikiQueryFilter<SwikiAnimeStatus>] = [],
        seasonFilters: [SwikiQueryFilter<SwikiSeason>] = [],
        score: Int? = nil,
        duration: SwikiAnimeDuration? = nil,
        rating: SwikiAnimeRating? = nil,
        genre: [Int] = [],
        genreV2: [Int] = [],
        studio: [Int] = [],
        franchise: [Int] = [],
        censored: Bool? = nil,
        mylist: SwikiUserRateStatus? = nil,
        ids: [Int] = [],
        excludeIDs: [Int] = [],
        search: String? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.order = order
        self.type = type
        self.season = season
        self.kindFilters = kindFilters
        self.statusFilters = statusFilters
        self.seasonFilters = seasonFilters
        self.score = score
        self.duration = duration
        self.rating = rating
        self.genre = genre
        self.genreV2 = genreV2
        self.studio = studio
        self.franchise = franchise
        self.censored = censored
        self.mylist = mylist
        self.ids = ids
        self.excludeIDs = excludeIDs
        self.search = search
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "order": order?.rawValue,
            "type": type,
            "kind": SwikiQueryEncoding.csv(filters: kindFilters),
            "status": SwikiQueryEncoding.csv(filters: statusFilters),
            "season": SwikiQueryEncoding.csv(single: season, filters: seasonFilters),
            "score": score.map(String.init),
            "duration": duration?.rawValue,
            "rating": rating?.rawValue,
            "genre": SwikiQueryEncoding.csv(genre),
            "genre_v2": SwikiQueryEncoding.csv(genreV2),
            "studio": SwikiQueryEncoding.csv(studio),
            "franchise": SwikiQueryEncoding.csv(franchise),
            "censored": censored.map(SwikiQueryEncoding.bool),
            "mylist": mylist?.rawValue,
            "ids": SwikiQueryEncoding.csv(ids),
            "exclude_ids": SwikiQueryEncoding.csv(excludeIDs),
            "search": search
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}

/// GET /api/animes/:id/topics
public struct SwikiV1AnimesTopicsQuery: SwikiQueryConvertible {
    public enum Kind: String, Sendable {
        case anons
        case ongoing
        case released
        case episode
    }
    public var page: Int?
    public var limit: Int?
    public var kind: Kind?
    public var episode: Int?
    public var extra: SwikiQuery

    /// GET /api/animes/:id/topics
    /// - Parameters:
    ///   - page: Must be a number between 1 and 100000.
    ///   - limit: 30 maximum.
    ///   - kind: kind
    ///   - episode: episode
    public init(
        page: Int? = nil,
        limit: Int? = nil,
        kind: Kind? = nil,
        episode: Int? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.kind = kind
        self.episode = episode
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page?.description,
            "limit": limit?.description,
            "kind": kind?.rawValue,
            "episode": episode?.description,
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }

}
