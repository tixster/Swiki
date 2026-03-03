import Foundation

public struct SwikiDialog: Decodable, Sendable {
    public let targetUser: SwikiUser
    public let message: SwikiMessage
    public let id: String?
    public let unreadMessagesCount: Int?
    public let lastMessage: SwikiMessage?
    public let createdAt: Date?
    public let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case targetUser = "target_user"
        case message
        case id
        case user
        case unreadMessagesCount = "unread_messages_count"
        case lastMessage = "last_message"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let targetUser = try container.decodeIfPresent(SwikiUser.self, forKey: .targetUser) {
            self.targetUser = targetUser
        } else {
            self.targetUser = try container.decode(SwikiUser.self, forKey: .user)
        }
        let message = try container.decodeIfPresent(SwikiMessage.self, forKey: .message)
        let legacyMessage = try container.decodeIfPresent(SwikiMessage.self, forKey: .lastMessage)
        if let message = message ?? legacyMessage {
            self.message = message
        } else {
            throw DecodingError.keyNotFound(
                CodingKeys.message,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Missing dialog message")
            )
        }
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id)
        self.unreadMessagesCount = try container.decodeIfPresent(Int.self, forKey: .unreadMessagesCount)
        self.lastMessage = try container.decodeIfPresent(SwikiMessage.self, forKey: .lastMessage)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
    }
}
