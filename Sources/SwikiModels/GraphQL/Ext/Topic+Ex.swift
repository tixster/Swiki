import Foundation
import GraphQLGeneratorMacros

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

