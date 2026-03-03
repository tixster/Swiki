import Foundation
import GraphQLGeneratorMacros

extension SwikiScoreStat: GraphQLGenerated.ScoreStat {

    func count(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        count
    }

    func score(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        score
    }

}

