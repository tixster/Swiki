import Foundation
import SwikiModels

public struct SwikiV1AnimesQuery: SwikiQueryConvertible {
    public let page: Int?
    public let limit: Int?
    public let order: SwikiOrder?
    public let kind: String?
    public let status: SwikiAnimeStatus?
    public let season: String?
    public let score: Int?
    public let duration: SwikiAnimeDuration?
    public let rating: SwikiAnimeRating?
    public let genre: [Int]
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
        kind: String? = nil,
        status: SwikiAnimeStatus? = nil,
        season: String? = nil,
        score: Int? = nil,
        duration: SwikiAnimeDuration? = nil,
        rating: SwikiAnimeRating? = nil,
        genre: [Int] = [],
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
        self.kind = kind
        self.status = status
        self.season = season
        self.score = score
        self.duration = duration
        self.rating = rating
        self.genre = genre
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
            "kind": kind,
            "status": status?.rawValue,
            "season": season,
            "score": score.map(String.init),
            "duration": duration?.rawValue,
            "rating": rating?.rawValue,
            "genre": SwikiQueryEncoding.csv(genre),
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
