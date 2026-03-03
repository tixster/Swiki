import Foundation
import GraphQLGeneratorMacros

public struct SwikiUser: Decodable, Sendable {
    @graphQLResolver public let id: String
    @graphQLResolver public let nickname: String
    @graphQLResolver public let url: URL?
    @graphQLResolver public let avatarUrl: URL
    @graphQLResolver public let lastOnlineAt: Date
}

extension SwikiUser: GraphQLGenerated.User {
    
    func avatarUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        avatarUrl.absoluteString
    }
    
    func lastOnlineAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: lastOnlineAt, key: .lastOnlineAt)
    }
    
    func url(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        url?.absoluteString ?? ""
    }

}
