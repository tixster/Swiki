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

extension SwikiTopic: GraphQLGenerated.Topic {

    func url(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        url.absoluteString
    }

    func createdAt(
        context: GraphQLContext,
        info: GraphQL.GraphQLResolveInfo
    ) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: createdAt, key: .createdAt)
    }
    
    func updatedAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: updatedAt, key: .updatedAt)
    }

}
