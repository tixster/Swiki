import Foundation
import SwikiModels

public struct SwikiV1TopicsQuery: SwikiQueryConvertible {
    public typealias Forum = SwikiTopicForum
    public typealias LinkedType = SwikiTopicLinkedType
    public typealias TopicType = SwikiTopicType

    public struct Page: RawRepresentable, Sendable {
        public var rawValue: Int

        public init?(rawValue: Int) {
            guard (1...100_000).contains(rawValue) else {
                return nil
            }
            self.rawValue = rawValue
        }

        public init?(_ rawValue: Int) {
            self.init(rawValue: rawValue)
        }
    }

    public struct Limit: RawRepresentable, Sendable {
        public var rawValue: Int

        public init?(rawValue: Int) {
            guard (1...30).contains(rawValue) else {
                return nil
            }
            self.rawValue = rawValue
        }

        public init?(_ rawValue: Int) {
            self.init(rawValue: rawValue)
        }
    }

    public var forum: Forum?
    public var linkedID: Int?
    public var linkedType: LinkedType?
    public var type: TopicType?
    public var page: Page?
    public var limit: Limit?
    public var extra: SwikiQuery

    public init(
        forum: Forum? = nil,
        linkedID: Int? = nil,
        linkedType: LinkedType? = nil,
        type: TopicType? = nil,
        page: Page? = nil,
        limit: Limit? = nil,
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
            "forum": forum?.rawValue,
            "linked_id": linkedID.map(String.init),
            "linked_type": linkedType?.rawValue,
            "type": type?.rawValue,
            "page": page.map { String($0.rawValue) },
            "limit": limit.map { String($0.rawValue) }
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
