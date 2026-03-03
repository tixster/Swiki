import Foundation
import GraphQLGeneratorMacros

extension SwikiTopic: GraphQLGenerated.Topic {
    func body(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        body
    }
    
    func commentsCount(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        commentsCount
    }
    
    func htmlBody(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        htmlBody
    }
    
    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        id
    }
    
    func tags(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        tags
    }
    
    func title(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        title
    }
    
    func _type(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        type
    }
    
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

