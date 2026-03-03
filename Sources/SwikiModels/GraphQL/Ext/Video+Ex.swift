import Foundation
import GraphQLGeneratorMacros

extension SwikiVideo: GraphQLGenerated.Video {

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        String(id)
    }

    func imageUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        imageUrl.absoluteString
    }

    func kind(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.VideoKindEnum {
        GraphQLGenerated.VideoKindEnum(rawValue: kind.rawValue) ?? .other
    }

    func name(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        name
    }

    func playerUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        playerUrl.absoluteString
    }

    func url(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        url.absoluteString
    }

}
