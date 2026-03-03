import Foundation
import SwikiModels

public struct SwikiV1TopicsQuery: SwikiQueryConvertible {
    public typealias Forum = SwikiTopicForum
    public typealias LinkedType = SwikiTopicLinkedType
    public typealias TopicType = SwikiTopicType

    public struct Page: RawRepresentable, Sendable {
        public let rawValue: Int

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
        public let rawValue: Int

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

    public let forum: Forum?
    public let linkedID: Int?
    public let linkedType: LinkedType?
    public let type: TopicType?
    public let page: Page?
    public let limit: Limit?
    public let extra: SwikiQuery

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
