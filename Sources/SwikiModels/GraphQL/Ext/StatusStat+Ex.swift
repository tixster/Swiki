import Foundation
import GraphQLGeneratorMacros

extension SwikiStatusStat: GraphQLGenerated.StatusStat {

    func count(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        count
    }

    func status(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.UserRateStatusEnum {
        GraphQLGenerated.UserRateStatusEnum(rawValue: status.rawValue) ?? .planned
    }

}

