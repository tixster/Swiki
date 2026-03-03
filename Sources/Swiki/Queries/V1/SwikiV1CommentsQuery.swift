import Foundation

public struct SwikiV1CommentsQuery: SwikiQueryConvertible {
    public let commentableID: Int?
    public let commentableType: String?
    public let page: Int?
    public let limit: Int?
    public let extra: SwikiQuery

    public init(
        commentableID: Int? = nil,
        commentableType: String? = nil,
        page: Int? = nil,
        limit: Int? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.commentableID = commentableID
        self.commentableType = commentableType
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "commentable_id": commentableID.map(String.init),
            "commentable_type": commentableType,
            "page": page.map(String.init),
            "limit": limit.map(String.init)
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
