import Foundation
import SwikiModels

public struct SwikiV1MangasQuery: SwikiQueryConvertible {
    public let page: Int?
    public let limit: Int?
    public let order: SwikiOrder?
    public let kind: String?
    public let status: String?
    public let season: String?
    public let score: Int?
    public let genre: [Int]
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
        kind: String? = nil,
        status: String? = nil,
        season: String? = nil,
        score: Int? = nil,
        genre: [Int] = [],
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
        self.kind = kind
        self.status = status
        self.season = season
        self.score = score
        self.genre = genre
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
            "kind": kind,
            "status": status,
            "season": season,
            "score": score.map(String.init),
            "genre": SwikiQueryEncoding.csv(genre),
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
