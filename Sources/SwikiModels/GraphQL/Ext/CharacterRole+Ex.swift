import Foundation
import GraphQLGeneratorMacros

extension SwikiCharacterRole: GraphQLGenerated.CharacterRole {

    func character(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> any GraphQLGenerated.Character {
        character
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func rolesEn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        rolesEn
    }

    func rolesRu(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        rolesRu
    }

}

