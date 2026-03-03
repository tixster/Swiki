import Foundation
import GraphQLGeneratorMacros

extension SwikiPersonRole: GraphQLGenerated.PersonRole {

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func person(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> any GraphQLGenerated.Person {
        person
    }

    func rolesEn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        rolesEn
    }

    func rolesRu(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        rolesRu
    }

}

