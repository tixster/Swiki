import Foundation
import GraphQLGeneratorMacros

extension SwikiRelated: GraphQLGenerated.Related {

    func anime(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Anime)? {
        anime
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func manga(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Manga)? {
        manga
    }

    func relationEn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        relationText
    }

    func relationKind(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.RelationKindEnum {
        GraphQLGenerated.RelationKindEnum(rawValue: relationKind.rawValue) ?? .other
    }

    func relationRu(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        relationText
    }

    func relationText(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        relationText
    }

}

