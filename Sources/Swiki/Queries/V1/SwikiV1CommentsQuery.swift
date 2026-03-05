import Foundation
import SwikiModels

public struct SwikiV1CommentsQuery: SwikiQueryConvertible {
    public var commentableID: Int?
    public var commentableType: SwikiCommentableType?
    public var desc: Bool?
    /// Must be a number between 1 and 100000.
    public var page: Limit_100_000?
    /// 30 maximum
    public var limit: Limit_30?
    public var extra: SwikiQuery

    public init(
        commentableID: Int? = nil,
        commentableType: SwikiCommentableType? = nil,
        desc: Bool? = nil,
        page: Limit_100_000? = nil,
        limit: Limit_30? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.commentableID = commentableID
        self.commentableType = commentableType
        self.desc = desc
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "commentable_id": commentableID.map(String.init),
            "commentable_type": commentableType?.rawValue,
            "desc": desc.map { $0 ? "1" : "0" },
            "page": page?.rawValue.description,
            "limit": limit?.rawValue.description
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
