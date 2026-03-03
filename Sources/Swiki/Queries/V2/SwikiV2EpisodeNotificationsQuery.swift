import Foundation

public struct SwikiV2EpisodeNotificationsQuery: SwikiQueryConvertible {
    public let page: Int?
    public let limit: Int?
    public let extra: SwikiQuery

    public init(page: Int? = nil, limit: Int? = nil, extra: SwikiQuery = [:]) {
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page.map(String.init),
            "limit": limit.map(String.init)
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
