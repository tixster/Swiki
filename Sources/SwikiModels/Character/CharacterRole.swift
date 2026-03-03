import Foundation

public struct SwikiCharacterRole: Decodable, Sendable {
    public let id: String
    public let character: SwikiCharacter
    public let rolesEn: [String]
    public let rolesRu: [String]
}

extension SwikiCharacterRole: GraphQLGenerated.CharacterRole {
    func character(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> any GraphQLGenerated.Character {
        <#code#>
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        <#code#>
    }

    func rolesEn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        <#code#>
    }

    func rolesRu(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        <#code#>
    }


}
