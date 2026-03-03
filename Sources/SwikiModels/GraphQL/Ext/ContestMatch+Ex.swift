import Foundation
import GraphQLGeneratorMacros

extension SwikiContestMatch: GraphQLGenerated.ContestMatch {

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func leftAnime(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Anime)? {
        leftAnime
    }

    func leftCharacter(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Character)? {
        leftCharacter
    }

    func leftId(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        leftId
    }

    func leftVotes(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        leftVotes
    }

    func rightAnime(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Anime)? {
        rightAnime
    }

    func rightCharacter(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Character)? {
        rightCharacter
    }

    func rightId(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        rightId
    }

    func rightVotes(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        rightVotes
    }

    func state(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.ContestMatchStateEnum {
        GraphQLGenerated.ContestMatchStateEnum(rawValue: state.rawValue) ?? .created
    }

    func winnerId(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int? {
        winnderId
    }

}

