import Foundation

public struct SwikiV1MessagesQuery: SwikiQueryConvertible {
    public let type: String?
    public let page: Int?
    public let limit: Int?
    public let extra: SwikiQuery

    public init(type: String? = nil, page: Int? = nil, limit: Int? = nil, extra: SwikiQuery = [:]) {
        self.type = type
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "type": type,
            "page": page.map(String.init),
            "limit": limit.map(String.init)
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
