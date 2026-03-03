import Foundation

public struct SwikiUser: Decodable, Sendable {
    public let id: String
    public let nickname: String
    public let url: URL?
    public let avatarUrl: URL
    public let lastOnlineAt: Date
}
