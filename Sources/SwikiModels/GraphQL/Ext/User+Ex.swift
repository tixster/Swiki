import Foundation
import GraphQLGeneratorMacros

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
