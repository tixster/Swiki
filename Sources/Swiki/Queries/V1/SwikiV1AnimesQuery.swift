import Foundation
import SwikiModels

public struct SwikiV1AnimesQuery: SwikiQueryConvertible {
    public typealias Filter<Value: RawRepresentable & Sendable> = SwikiQueryFilter<Value> where Value.RawValue == String

    public let page: Int?
    public let limit: Int?
    public let order: SwikiOrder?
    public let type: String?
    public let season: SwikiSeason?
    /// Supports grouped/subtraction/combined modes:
    /// - include: `tv,movie`
    /// - exclude: `!tv,!movie`
    /// - mixed: `tv,!movie`
    public let kindFilters: [SwikiQueryFilter<SwikiAnimeKind>]
    /// Supports grouped/subtraction/combined modes for status values.
    public let statusFilters: [SwikiQueryFilter<SwikiAnimeStatus>]
    /// Supports grouped/subtraction/combined modes:
    /// - include: `2016,2015`
    /// - exclude: `!2016,!2015`
    /// - mixed: `2016,!summer_2016`
    public let seasonFilters: [SwikiQueryFilter<SwikiSeason>]
    public let score: Int?
    public let duration: SwikiAnimeDuration?
    public let rating: SwikiAnimeRating?
    public let genre: [Int]
    public let genreV2: [Int]
    public let studio: [Int]
    public let franchise: [Int]
    public let censored: Bool?
    public let mylist: SwikiUserRateStatus?
    public let ids: [Int]
    public let excludeIDs: [Int]
    public let search: String?
    public let extra: SwikiQuery

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
