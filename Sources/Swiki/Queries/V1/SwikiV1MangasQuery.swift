import Foundation
import SwikiModels

public struct SwikiV1MangasQuery: SwikiQueryConvertible {
    public typealias Filter<Value: RawRepresentable & Sendable> = SwikiQueryFilter<Value> where Value.RawValue == String
    /// Must be a number between 1 and 100000.
    public var page: Int?
    /// limit: 50 maximum.
    public var limit: Int?
    public var order: SwikiOrder?
    /// - Warning: API Deprecated
    public var type: String?
    /// Supports grouped/subtraction/combined modes:
    /// - include: `manga,one_shot`
    /// - exclude: `!manga,!one_shot`
    /// - mixed: `manga,!one_shot`
    public var kindFilters: [SwikiQueryFilter<SwikiMangaKind>]
    public var status: SwikiMangaStatus?
    public var season: SwikiSeason?
    /// Supports grouped/subtraction/combined modes:
    /// - include: `2016,2015`
    /// - exclude: `!2016,!2015`
    /// - mixed: `2016,!summer_2016`
    public var seasonFilters: [SwikiQueryFilter<SwikiSeason>]
    /// Minimal manga score
    public var score: Int?
    /// List of genre ids separated by comma
    public var genre: [Int]
    /// List of genre v2 ids separated by comma
    public var genreV2: [Int]
    /// List of studio ids separated by comma
    public var franchise: [Int]
    /// List of publisher ids separated by comma
    public var publisher: [Int]
    /// Set to false to allow hentai, yaoi and yuri
    public var censored: Bool?
    /// Status of manga in current user list
    public var mylist: SwikiUserRateStatus?
    /// List of manga ids separated by comma
    public var ids: [Int]
    /// List of manga ids separated by comma
    public var excludeIDs: [Int]
    /// Search phrase to filter mangas by name
    public var search: String?
    /// extra fields
    public var extra: SwikiQuery

    /// GET /api/mangas
    /// - Parameters:
    ///   - page: Must be a number between 1 and 100000.
    ///   - limit: 50 maximum.
    ///   - order: order type
    ///   - type: API Deprecated
    ///   - season: Season
    ///   - kindFilters: kindFilters
    ///   - statusFilters: statusFilters
    ///   - seasonFilters: seasonFilters
    ///   - score: Minimal manga score
    ///   - duration: duration
    ///   - rating: rating
    ///   - genre: List of genre ids separated by comma
    ///   - genreV2: List of genre v2 ids separated by comma
    ///   - studio: List of studio ids separated by comma
    ///   - franchise: List of franchises separated by comma
    ///   - publisher: List of publisher ids separated by comma
    ///   - censored: Set to false to allow hentai, yaoi and yuri
    ///   - mylist: Status of manga in current user list
    ///   - ids: List of manga ids separated by comma
    ///   - excludeIDs: List of manga ids separated by comma
    ///   - search: Search phrase to filter mangas by name
    ///   - extra: extra fields
    public init(
        page: Int? = nil,
        limit: Int? = nil,
        order: SwikiOrder? = nil,
        type: String? = nil,
        kindFilters: [SwikiQueryFilter<SwikiMangaKind>] = [],
        status: SwikiMangaStatus? = nil,
        season: SwikiSeason? = nil,
        seasonFilters: [SwikiQueryFilter<SwikiSeason>] = [],
        score: Int? = nil,
        genre: [Int] = [],
        genreV2: [Int] = [],
        franchise: [Int] = [],
        publisher: [Int] = [],
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
        self.kindFilters = kindFilters
        self.status = status
        self.season = season
        self.seasonFilters = seasonFilters
        self.score = score
        self.genre = genre
        self.genreV2 = genreV2
        self.franchise = franchise
        self.publisher = publisher
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
            "status": status?.rawValue,
            "season": SwikiQueryEncoding.csv(single: season, filters: seasonFilters),
            "score": score.map(String.init),
            "genre": SwikiQueryEncoding.csv(genre),
            "genre_v2": SwikiQueryEncoding.csv(genreV2),
            "franchise": SwikiQueryEncoding.csv(franchise),
            "publisher": SwikiQueryEncoding.csv(publisher),
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
