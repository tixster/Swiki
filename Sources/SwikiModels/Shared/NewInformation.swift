import Foundation

public struct SwikiNewInformation: Decodable, Sendable {
    public let messages: Int
    public let news: Int
    public let notifications: Int
}
