import Foundation
import SwikiModels

public struct SwikiV1MangasQuery: SwikiQueryConvertible {
    public typealias Filter<Value: RawRepresentable & Sendable> = SwikiQueryFilter<Value> where Value.RawValue == String

    public let page: Int?
    public let limit: Int?
    public let order: SwikiOrder?
    public let type: String?
    /// Supports grouped/subtraction/combined modes:
    /// - include: `manga,one_shot`
    /// - exclude: `!manga,!one_shot`
    /// - mixed: `manga,!one_shot`
    public let kindFilters: [SwikiQueryFilter<SwikiMangaKind>]
    public let status: String?
    public let season: SwikiSeason?
    /// Supports grouped/subtraction/combined modes:
    /// - include: `2016,2015`
    /// - exclude: `!2016,!2015`
    /// - mixed: `2016,!summer_2016`
    public let seasonFilters: [SwikiQueryFilter<SwikiSeason>]
    public let score: Int?
    public let genre: [Int]
    public let genreV2: [Int]
    public let franchise: [Int]
    public let publisher: [Int]
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
        kindFilters: [SwikiQueryFilter<SwikiMangaKind>] = [],
        status: String? = nil,
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
            "status": status,
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
