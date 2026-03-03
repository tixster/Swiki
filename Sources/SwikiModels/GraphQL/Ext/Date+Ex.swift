import Foundation
import GraphQLGeneratorMacros

extension Date {
    var graphQLISO8601DateTime: GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: self, key: .createdAt)
    }

    var graphQLISO8601Date: GraphQLScalars.ISO8601Date {
        GraphQLScalars.ISO8601Date(date: self, key: .createdAt)
    }
}
