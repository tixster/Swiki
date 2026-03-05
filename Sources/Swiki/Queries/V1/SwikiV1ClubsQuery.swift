import Foundation

public struct SwikiV1ClubsSearchQuery: SwikiQueryConvertible {
    /// Must be a number between 1 and 100000.
    public var page: Limit_100_000?
    /// 30 maximum
    public var limit: Limit_30?
    public var search: String?
    public var extra: SwikiQuery
    
    /// GET /api/clubs
    /// - Parameters:
    ///   - page: Must be a number between 1 and 100000.
    ///   - limit: 30 maximum
    ///   - search: search
    ///   - extra: extra
    public init(
        page: Limit_100_000? = nil,
        limit: Limit_30? = nil,
        search: String? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.search = search
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page?.rawValue.description,
            "limit": limit?.rawValue.description,
            "search": search
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}

public struct SwikiV1ClubsQuery: SwikiQueryConvertible {
    /// Must be a number between 1 and 100000.
    public var page: Limit_100_000?
    /// 30 maximum
    public var limit: Limit_30?
    public var extra: SwikiQuery

    /// GET /api/clubs
    /// - Parameters:
    ///   - page: Must be a number between 1 and 100000.
    ///   - limit: 30 maximum
    ///   - search: search
    ///   - extra: extra
    public init(
        page: Limit_100_000? = nil,
        limit: Limit_30? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page?.rawValue.description,
            "limit": limit?.rawValue.description,
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
