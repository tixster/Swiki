import Foundation

public struct SwikiMessageMarkReadPayload: Encodable, Sendable {
    public let ids: [String]
    public let isRead: String

    public init(ids: [String], isRead: Bool) {
        self.ids = ids
        self.isRead = isRead ? 1.description : 0.description
    }
}
