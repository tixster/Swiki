import Foundation
import GraphQLGeneratorMacros

extension SwikiPoster: GraphQLGenerated.Poster {

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func main2xUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        main2xUrl.absoluteString
    }

    func mainAlt2xUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        mainAlt2xUrl.absoluteString
    }

    func mainAltUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        mainAltUrl.absoluteString
    }

    func mainUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        mainUrl.absoluteString
    }

    func mini2xUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        mini2xUrl.absoluteString
    }

    func miniAlt2xUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        miniAlt2xUrl.absoluteString
    }

    func miniAltUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        miniAltUrl.absoluteString
    }

    func miniUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        miniUrl.absoluteString
    }

    func originalUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        originalUrl.absoluteString
    }

    func preview2xUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        preview2xUrl.absoluteString
    }

    func previewAlt2xUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        previewAlt2xUrl.absoluteString
    }

    func previewAltUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        previewAltUrl.absoluteString
    }

    func previewUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        previewUrl.absoluteString
    }

}

