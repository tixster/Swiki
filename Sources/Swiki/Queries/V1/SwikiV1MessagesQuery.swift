import Foundation

public struct SwikiV1MessagesQuery: SwikiQueryConvertible {
    public let type: String?
    public let ids: [String]
    public let isRead: Bool?
    public let page: Int?
    public let limit: Int?
    public let extra: SwikiQuery

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
