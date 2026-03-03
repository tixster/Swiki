import Foundation
import GraphQLGeneratorMacros

extension SwikiPerson: GraphQLGenerated.Person {

    func birthOn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.IncompleteDate)? {
        birthOn
    }

    func createdAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: createdAt, key: .createdAt)
    }

    func deceasedOn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.IncompleteDate)? {
        deceasedOn
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func isMangaka(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Bool {
        isMangaka
    }

    func isProducer(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Bool {
        isProducer
    }

    func isSeyu(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Bool {
        isSeyu
    }

    func japanese(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        japanese
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

    func website(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        website?.absoluteString
    }

}

