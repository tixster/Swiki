import Foundation
import SwikiModels

struct SwikiTopicCreatePayloadBody: Encodable, Sendable {
    let topic: SwikiTopicCreatePayload
}

public struct SwikiTopicCreatePayload: Encodable, Sendable {
    public let body: String
    public let title: String
    public let type: SwikiTopicType
    public let userId: String
    public let forumId: String
    public let linkedId: String?
    public let linkedType: SwikiTopicLinkedType?

    enum CodingKeys: String, CodingKey {
        case body
        case title
        case type
        case userId = "user_id"
        case forumId = "forum_id"
        case linkedId = "linked_id"
        case linkedType = "linked_type"
    }

    public init(
        body: String,
        title: String,
        type: SwikiTopicType = .topic,
        userId: String,
        forumId: String,
        linkedId: String?,
        linkedType: SwikiTopicLinkedType?
    ) {
        self.body = body
        self.title = title
        self.type = type
        self.userId = userId
        self.forumId = forumId
        self.linkedId = linkedId
        self.linkedType = linkedType
    }

}
