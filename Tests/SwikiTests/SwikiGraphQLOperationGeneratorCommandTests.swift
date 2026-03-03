import Foundation
import Testing
@testable import SwikiGraphQLOperationGenerator

@Suite("SwikiGraphQLOperationGeneratorCommand")
struct SwikiGraphQLOperationGeneratorCommandTests {

    @Test
    func generatesOperationFilesInMemory() throws {
        let schema = """
        schema {
          query: Query
        }

        scalar PositiveInt
        scalar ISO8601DateTime

        type Query {
          hello: String!
          userRates(page: PositiveInt = 1): [UserRate!]!
        }

        type UserRate {
          id: ID!
          createdAt: ISO8601DateTime!
        }
        """

        let operationSources: [SwikiGraphQLOperationSource] = [
            SwikiGraphQLOperationSource(
                path: "hello.graphql",
                source: """
                query Hello {
                  hello
                }
                """
            ),
            SwikiGraphQLOperationSource(
                path: "user_rates.graphql",
                source: """
                query UserRates($page: PositiveInt = 1) {
                  userRates(page: $page) {
                    id
                    createdAt
                  }
                }
                """
            )
        ]

        let files = try generateSwikiGraphQLOperationFilesInMemory(
            schemaSource: schema,
            operationSources: operationSources
        )

        #expect(files.count == 3)

        let byName = Dictionary(uniqueKeysWithValues: files.map { ($0.fileName, $0.content) })
        let namespace = try #require(byName["SwikiGraphQLOperations.generated.swift"])
        let hello = try #require(byName["SwikiGraphQLOperations+HelloOperation.generated.swift"])
        let userRates = try #require(byName["SwikiGraphQLOperations+UserRatesOperation.generated.swift"])

        #expect(namespace.contains("public enum SwikiGraphQLOperations {}"))
        #expect(hello.contains("public extension SwikiGraphQLOperations {"))
        #expect(hello.contains("struct HelloOperation: SwikiGraphQLOperation {"))
        #expect(hello.contains("public static let operationDocument: String = \"\"\""))
        #expect(userRates.contains("struct UserRatesOperation: SwikiGraphQLOperation {"))
    }

    @Test
    func throwsForUnnamedOperationInMemory() {
        let schema = """
        schema {
          query: Query
        }

        type Query {
          hello: String!
        }
        """

        let operationSources: [SwikiGraphQLOperationSource] = [
            SwikiGraphQLOperationSource(
                path: "invalid.graphql",
                source: """
                query {
                  hello
                }
                """
            )
        ]

        do {
            _ = try generateSwikiGraphQLOperationFilesInMemory(
                schemaSource: schema,
                operationSources: operationSources
            )
            #expect(Bool(false), "Expected generator to throw for unnamed operation")
        } catch {
            let message = (error as NSError).localizedDescription
            let description = String(describing: error)
            #expect(message.contains("must have a name") || description.contains("must have a name"))
        }
    }
}
