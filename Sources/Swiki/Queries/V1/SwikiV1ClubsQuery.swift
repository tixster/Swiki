import Foundation

public struct SwikiV1ClubsSearchQuery: SwikiQueryConvertible {
    /// Must be a number between 1 and 100000.
    public var page: Int?
    /// 30 maximum
    public var limit: Int?
    public var search: String?
    public var extra: SwikiQuery
    
    /// GET /api/clubs
    /// - Parameters:
    ///   - page: Must be a number between 1 and 100000.
    ///   - limit: 30 maximum
    ///   - search: search
    ///   - extra: extra
    public init(
        page: Int? = nil,
        limit: Int? = nil,
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
            "page": page?.description,
            "limit": limit?.description,
            "search": search
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}

public struct SwikiV1ClubsQuery: SwikiQueryConvertible {
    /// Must be a number between 1 and 100000.
    public var page: Int?
    /// 30 maximum
    public var limit: Int?
    public var extra: SwikiQuery

    /// GET /api/clubs
    /// - Parameters:
    ///   - page: Must be a number between 1 and 100000.
    ///   - limit: 30 maximum
    ///   - search: search
    ///   - extra: extra
    public init(
        page: Int? = nil,
        limit: Int? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page?.description,
            "limit": limit?.description,
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
