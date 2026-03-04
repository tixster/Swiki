import Foundation
import SwikiModels

public struct SwikiV1UsersSearchQuery: SwikiQueryConvertible {
    public var page: Int?
    public var limit: Int?
    public var search: String?
    public var extra: SwikiQuery

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
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "search": search
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }

}

public struct SwikiV1UsersQuery: SwikiQueryConvertible {
    public var page: Int?
    public var limit: Int?
    public var extra: SwikiQuery

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
            "page": page.map(String.init),
            "limit": limit.map(String.init),
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }

}

public struct SwikiV1UsersRatesQuery: SwikiQueryConvertible {
    /// Must be a number between 1 and 100000.
    public var page: Int?
    /// 5000 maximum
    public var limit: Int?
    public var status: SwikiUserRateStatus?
    public var censored: Bool?
    public var extra: SwikiQuery

    public init(
        page: Int? = nil,
        limit: Int? = nil,
        status: SwikiUserRateStatus? = nil,
        censored: Bool? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.status = status
        self.censored = censored
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "status": status?.rawValue,
            "censored": censored.map(SwikiQueryEncoding.bool)
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}

public struct SwikiV1UserMessagesQuery: SwikiQueryConvertible {
    public var type: SwikiMessageKind?
    /// Must be a number between 1 and 100000.
    public var page: Int?
    /// 100 maximum
    public var limit: Int?
    public var extra: SwikiQuery

    public init(
        type: SwikiMessageKind? = nil,
        page: Int? = nil,
        limit: Int? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.type = type
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "type": type?.rawValue.lowercased(),
            "page": page.map(String.init),
            "limit": limit.map(String.init)
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
