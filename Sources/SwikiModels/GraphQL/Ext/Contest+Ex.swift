import Foundation
import GraphQLGeneratorMacros

extension SwikiContest: GraphQLGenerated.Contest {

    func description(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        description
    }

    func descriptionHtml(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        descriptionHtml
    }

    func descriptionSource(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        descriptionSource
    }

    func finishedOn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601Date? {
        nil
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func matchDuration(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        matchDuration
    }

    func matchesInterval(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        matchesInterval
    }

    func matchesPerRound(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        matchesPerRound
    }

    func memberType(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.ContestMemberTypeEnum {
        GraphQLGenerated.ContestMemberTypeEnum(rawValue: memberType.rawValue) ?? .anime
    }

    func name(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        name
    }

    func rounds(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.ContestRound] {
        rounds.map { $0 as any GraphQLGenerated.ContestRound }
    }

    func startedOn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601Date? {
        nil
    }

    func state(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.ContestStateEnum {
        GraphQLGenerated.ContestStateEnum(rawValue: state.rawValue) ?? .created
    }

    func strategyType(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.ContestStrategyTypeEnum {
        GraphQLGenerated.ContestStrategyTypeEnum(rawValue: strategyType.rawValue) ?? .swiss
    }

}

