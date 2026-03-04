import Foundation

public enum SwikiMessageKind: String, Codable, Sendable {
    case `private` = "Private"
    case notifications = "Notifications"
    case news = "News"
    case inbox = "Inbox"
    case sent = "Sent"
    case unknown
}
