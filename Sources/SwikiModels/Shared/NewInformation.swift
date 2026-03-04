import Foundation

public struct SwikiUnreadMessagesInformation: Decodable, Sendable {
    public let messages: Int
    public let news: Int
    public let notifications: Int
}
