import Foundation
import GraphQLGeneratorMacros

extension SwikiGenre: GraphQLGenerated.Genre {

    func entryType(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.GenreEntryTypeEnum {
        GraphQLGenerated.GenreEntryTypeEnum(rawValue: entryType.rawValue) ?? .anime
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func kind(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.GenreKindEnum {
        GraphQLGenerated.GenreKindEnum(rawValue: kind.rawValue) ?? .genre
    }

    func name(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        name
    }

    func russian(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        russian
    }

}

