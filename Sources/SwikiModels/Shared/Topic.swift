import Foundation
import GraphQLGeneratorMacros

public struct SwikiTopic: Decodable, Sendable {
    @graphQLResolver public let id: String?
    @graphQLResolver public let title: String
    @graphQLResolver public let body: String
    @graphQLResolver public let tags: [String]
    @graphQLResolver(name: "_type") public let type: String
    @graphQLResolver public let url: URL
    @graphQLResolver public let htmlBody: String
    @graphQLResolver public let commentsCount: Int
    @graphQLResolver public let createdAt: Date
    @graphQLResolver public let updatedAt: Date
}
