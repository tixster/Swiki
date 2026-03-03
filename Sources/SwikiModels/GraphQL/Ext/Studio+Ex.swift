import Foundation
import GraphQLGeneratorMacros

extension SwikiStudio: GraphQLGenerated.Studio {

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func imageUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        imageUrl?.absoluteString
    }

    func name(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        name
    }

}

