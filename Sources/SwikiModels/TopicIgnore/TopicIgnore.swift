import Foundation

public struct SwikiTopicIgnore: Decodable, Sendable {
    public let topicId: String
    public let isIgnored: Bool

    enum CodingKeys: String, CodingKey {
        case topicId = "topic_id"
        case isIgnored = "is_ignored"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.topicId = try container.decodeStringOrInt(forKey: .topicId)
        self.isIgnored = try container.decode(Bool.self, forKey: .isIgnored)
    }
}
