import Foundation

public struct SwikiV1TopicsQuery: SwikiQueryConvertible {
    public let forum: String?
    public let linkedID: Int?
    public let linkedType: String?
    public let type: String?
    public let page: Int?
    public let limit: Int?
    public let extra: SwikiQuery

    public init(
        forum: String? = nil,
        linkedID: Int? = nil,
        linkedType: String? = nil,
        type: String? = nil,
        page: Int? = nil,
        limit: Int? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.forum = forum
        self.linkedID = linkedID
        self.linkedType = linkedType
        self.type = type
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "forum": forum,
            "linked_id": linkedID.map(String.init),
            "linked_type": linkedType,
            "type": type,
            "page": page.map(String.init),
            "limit": limit.map(String.init)
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
