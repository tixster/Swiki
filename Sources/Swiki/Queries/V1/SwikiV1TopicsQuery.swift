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

    public struct Page: Limitable {
        public var rawValue: Int

        public init?(rawValue: Int) {
            let max = 100_000
            if (1...max).contains(rawValue) {
                self.rawValue = rawValue
            } else {
                self.rawValue = max
            }
        }

        public init(integerLiteral value: IntegerLiteralType) {
            let max = 100_000
            if (1...max).contains(value) {
                self.rawValue = value
            } else {
                self.rawValue = max
            }
        }

    }

    public struct Limit: Limitable {
        public var rawValue: Int

        public init?(rawValue: Int) {
            guard (1...30).contains(rawValue) else {
                return nil
            }
            self.rawValue = rawValue
        }

        public init(integerLiteral value: IntegerLiteralType) {
            let max = 30
            if (1...max).contains(value) {
                self.rawValue = value
            } else {
                self.rawValue = max
            }
        }

    }

    public var forum: Forum?
    public var linked: Linked?
    public var type: TopicType?
    public var page: Page?
    public var limit: Limit?
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
        page: Page? = nil,
        limit: Limit? = nil,
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

    public struct Page: Limitable {
        public var rawValue: Int

        public init?(rawValue: Int) {
            let max = 100_000
            if (1...max).contains(rawValue) {
                self.rawValue = rawValue
            } else {
                self.rawValue = max
            }
        }

        public init(integerLiteral value: IntegerLiteralType) {
            let max = 100_000
            if (1...max).contains(value) {
                self.rawValue = value
            } else {
                self.rawValue = max
            }
        }

    }

    public struct Limit: Limitable {
        public var rawValue: Int

        public init?(rawValue: Int) {
            let max = 30
            if (1...max).contains(rawValue) {
                self.rawValue = rawValue
            } else {
                self.rawValue = max
            }
        }

        public init(integerLiteral value: IntegerLiteralType) {
            let max = 30
            if (1...max).contains(value) {
                self.rawValue = value
            } else {
                self.rawValue = max
            }
        }

    }

    public var page: Page?
    public var limit: Limit?
    public var extra: SwikiQuery

    public init(
        page: Page? = nil,
        limit: Limit? = nil,
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

    public struct Limit: Limitable {
        public var rawValue: Int

        public init?(rawValue: Int) {
            let max = 10
            if (1...max).contains(rawValue) {
                self.rawValue = rawValue
            } else {
                self.rawValue = max
            }
        }

        public init(integerLiteral value: IntegerLiteralType) {
            let max = 10
            if (1...max).contains(value) {
                self.rawValue = value
            } else {
                self.rawValue = max
            }
        }

    }

    public var limit: Limit?
    public var extra: SwikiQuery

    public init(
        limit: Limit? = nil,
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
