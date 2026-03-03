import Foundation

public struct SwikiUserIgnore: Decodable, Sendable {
    public let userId: String
    public let isIgnored: Bool

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isIgnored = "is_ignored"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decodeStringOrInt(forKey: .userId)
        self.isIgnored = try container.decode(Bool.self, forKey: .isIgnored)
    }
}
