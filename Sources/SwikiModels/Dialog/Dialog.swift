import Foundation

public struct SwikiDialog: Decodable, Sendable {
    public let id: String
    public let user: SwikiUser
    public let unreadMessagesCount: Int
    public let lastMessage: SwikiMessage?
    public let createdAt: Date
    public let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case user
        case unreadMessagesCount = "unread_messages_count"
        case lastMessage = "last_message"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.user = try container.decode(SwikiUser.self, forKey: .user)
        self.unreadMessagesCount = try container.decode(Int.self, forKey: .unreadMessagesCount)
        self.lastMessage = try container.decodeIfPresent(SwikiMessage.self, forKey: .lastMessage)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
}
