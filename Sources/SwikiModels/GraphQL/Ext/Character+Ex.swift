import Foundation
import GraphQLGeneratorMacros

extension SwikiCharacter: GraphQLGenerated.Character {

    func createdAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: createdAt, key: .createdAt)
    }

    func description(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        description
    }

    func descriptionHtml(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        descriptionHtml
    }

    func descriptionSource(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        descriptionSource
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func isAnime(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Bool {
        false
    }

    func isManga(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Bool {
        false
    }

    func isRanobe(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Bool {
        false
    }

    func japanese(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        nil
    }

    func malId(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        malId
    }

    func name(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        name
    }

    func poster(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Poster)? {
        poster
    }

    func russian(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        russian
    }

    func synonyms(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        synonyms
    }

    func topic(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Topic)? {
        topic
    }

    func updatedAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: updatedAt, key: .updatedAt)
    }

    func url(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        url.absoluteString
    }

}

