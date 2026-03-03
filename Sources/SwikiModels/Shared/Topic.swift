import Foundation

public struct SwikiTopic: Decodable, Sendable {
    public let id: String?
    public let title: String
    public let body: String
    public let tags: [String]
    public let type: String
    public let url: URL
    public let htmlBody: String
    public let commentsCount: Int
    public let createdAt: Date
    public let updatedAt: Date
}
