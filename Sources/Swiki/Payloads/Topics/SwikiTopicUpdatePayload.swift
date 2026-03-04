import Foundation
import SwikiModels

struct SwikiTopicUpdatePayloadBody: Encodable, Sendable {
    let topic: SwikiTopicUpdatePayload
}

public struct SwikiTopicUpdatePayload: Encodable, Sendable {
    public let body: String?
    public let title: String?
    public let linkedId: String?
    public let linkedType: SwikiTopicLinkedType?

    enum CodingKeys: String, CodingKey {
        case body
        case title
        case linkedId = "linked_id"
        case linkedType = "linked_type"
    }

    public init(
        body: String?,
        title: String?,
        linkedId: String?,
        linkedType: SwikiTopicLinkedType?
    ) {
        self.body = body
        self.title = title
        self.linkedId = linkedId
        self.linkedType = linkedType
    }

}
