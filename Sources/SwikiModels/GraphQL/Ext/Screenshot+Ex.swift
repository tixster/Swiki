import Foundation
import GraphQLGeneratorMacros

extension SwikiScreenshot: GraphQLGenerated.Screenshot {

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func originalUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        originalUrl.absoluteString
    }

    func x166Url(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        x166Url.absoluteString
    }

    func x332Url(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        x332Url.absoluteString
    }

}

