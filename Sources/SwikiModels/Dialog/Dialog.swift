import Foundation

public struct SwikiDialog: Decodable, Sendable {
    public let targetUser: SwikiUser
    public let message: SwikiMessagePreview

    enum CodingKeys: String, CodingKey {
        case targetUser = "target_user"
        case message
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.targetUser = try container.decode(SwikiUser.self, forKey: .targetUser)
        self.message = try container.decode(SwikiMessagePreview.self, forKey: .message)
    }

}
