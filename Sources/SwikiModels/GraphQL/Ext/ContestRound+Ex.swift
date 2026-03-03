import Foundation
import GraphQLGeneratorMacros

extension SwikiContestRound: GraphQLGenerated.ContestRound {

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func isAdditional(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Bool {
        isAdditional
    }

    func matches(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.ContestMatch] {
        matches.map { $0 as any GraphQLGenerated.ContestMatch }
    }

    func name(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        name
    }

    func number(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        number
    }

    func state(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.ContestRoundStateEnum {
        GraphQLGenerated.ContestRoundStateEnum(rawValue: state.rawValue) ?? .created
    }

}

