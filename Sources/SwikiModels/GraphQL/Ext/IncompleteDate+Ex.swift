import Foundation
import GraphQLGeneratorMacros

extension SwikiIncompleteDate: GraphQLGenerated.IncompleteDate {

    func date(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601Date? {
        date?.graphQLISO8601Date
    }

    func day(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        day
    }

    func month(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        month
    }

    func year(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        year
    }

}

