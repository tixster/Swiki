import Foundation
import SwikiModels

public struct SwikiV1TopicsSearchQuery: SwikiQueryConvertible {
    public typealias Forum = SwikiTopicForum
    public typealias LinkedType = SwikiTopicLinkedType
    public typealias TopicType = SwikiTopicType

    public struct Linked: Sendable {
        public var id: Int
        public var type: LinkedType
        public init(linkedId: Int, linkedType: LinkedType) {
            self.id = linkedId
            self.type = linkedType
        }
    }

    public var forum: Forum?
    public var linked: Linked?
    public var type: TopicType?
    public var page: Limit_100_000?
    public var limit: Limit_30?
    public var extra: SwikiQuery

    /// - Parameters:
    ///   - forum: forum
    ///
    ///   - type: type
    ///   - page: Must be a number between 1 and 100000.
    ///   - limit: 30 maximum
    ///   - extra: extra
    public init(
        forum: Forum? = nil,
        linked: Linked? = nil,
        type: TopicType? = nil,
        page: Limit_100_000? = nil,
        limit: Limit_30? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.forum = forum
        self.linked = linked
        self.type = type
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "forum": forum?.rawValue,
            "linked_id": linked?.id.description,
            "linked_type": linked?.type.rawValue,
            "type": type?.rawValue,
            "page": page.map { String($0.rawValue) },
            "limit": limit.map { String($0.rawValue) }
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}

public struct SwikiV1TopicsQuery: SwikiQueryConvertible {

    public var page: Limit_100_000?
    public var limit: Limit_30?
    public var extra: SwikiQuery

    public init(
        page: Limit_100_000? = nil,
        limit: Limit_30? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page.map { String($0.rawValue) },
            "limit": limit.map { String($0.rawValue) }
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }

}

public struct SwikiV1TopicsHotQuery: SwikiQueryConvertible {

    public var limit: Limit_10?
    public var extra: SwikiQuery

    public init(
        limit: Limit_10? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.limit = limit
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "limit": limit.map { String($0.rawValue) }
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }

}
