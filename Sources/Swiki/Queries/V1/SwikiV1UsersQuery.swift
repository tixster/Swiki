import Foundation

public struct SwikiV1UsersQuery: SwikiQueryConvertible {
    public let page: Int?
    public let limit: Int?
    public let search: String?
    public let extra: SwikiQuery

    public init(page: Int? = nil, limit: Int? = nil, search: String? = nil, extra: SwikiQuery = [:]) {
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
