import Foundation
import GraphQLGeneratorMacros

extension SwikiExternalLink: GraphQLGenerated.ExternalLink {

    func createdAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime? {
        createdAt?.graphQLISO8601DateTime
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        id
    }

    func kind(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.ExternalLinkKindEnum {
        GraphQLGenerated.ExternalLinkKindEnum(rawValue: kind.rawValue) ?? .officialSite
    }

    func updatedAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime? {
        updatedAt?.graphQLISO8601DateTime
    }

    func url(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        url.absoluteString
    }

}

