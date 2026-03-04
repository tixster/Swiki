import Foundation
import SwikiModels

public struct SwikiV1CommentsQuery: SwikiQueryConvertible {
    public var commentableID: Int?
    public var commentableType: SwikiCommentableType?
    public var desc: Bool?
    public var page: Int?
    public var limit: Int?
    public var extra: SwikiQuery

    public init(
        commentableID: Int? = nil,
        commentableType: SwikiCommentableType? = nil,
        desc: Bool? = nil,
        page: Int? = nil,
        limit: Int? = nil,
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
            "page": page.map(String.init),
            "limit": limit.map(String.init)
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
