import Foundation
import GraphQLGeneratorMacros

extension SwikiUserRate: GraphQLGenerated.UserRate {

    func anime(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Anime)? {
        nil
    }

    func chapters(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        chapters
    }

    func createdAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: createdAt, key: .createdAt)
    }

    func episodes(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        episodes
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func manga(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Manga)? {
        nil
    }

    func rewatches(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        rewatches
    }

    func score(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        score
    }

    func status(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.UserRateStatusEnum {
        GraphQLGenerated.UserRateStatusEnum(rawValue: status.rawValue) ?? .planned
    }

    func text(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        text
    }

    func updatedAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: updatedAt, key: .updatedAt)
    }

    func volumes(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        volumes
    }

}

