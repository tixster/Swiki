import Foundation

public struct SwikiV1MessagesQuery: SwikiQueryConvertible {
    public var type: String?
    public var ids: [String]
    public var isRead: Bool?
    public var page: Int?
    public var limit: Int?
    public var extra: SwikiQuery

    public init(
        type: String? = nil,
        ids: [String] = [],
        isRead: Bool? = nil,
        page: Int? = nil,
        limit: Int? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.type = type
        self.ids = ids
        self.isRead = isRead
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "type": type,
            "ids": SwikiQueryEncoding.csv(ids),
            "is_read": isRead.map { $0 ? "1" : "0" },
            "page": page.map(String.init),
            "limit": limit.map(String.init)
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
