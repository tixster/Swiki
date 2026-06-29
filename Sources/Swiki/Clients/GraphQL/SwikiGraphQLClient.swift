import Foundation
import SwikiModels

public enum SwikiGraphQLClientError: Error, LocalizedError, Sendable {
    case invalidVariablesPayload

    public var errorDescription: String? {
        switch self {
        case .invalidVariablesPayload:
            "GraphQL variables must encode to a dictionary object"
        }
    }
}

public struct SwikiGraphQLClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }

    @concurrent
    public func execute(request: GraphQLRequest) async throws -> GraphQLResult {
        try await transport.graphQL(request: request)
    }

    @concurrent
    public func execute<Variables: Encodable & Sendable>(
        query: String,
        operationName: String? = nil,
        variables: Variables
    ) async throws -> GraphQLResult {
        let request = try makeRequest(
            query: query,
            operationName: operationName,
            variables: variables
        )
        return try await execute(request: request)
    }

    @concurrent
    public func execute(
        query: String,
        operationName: String? = nil,
        variables: [String: Map] = [:]
    ) async throws -> GraphQLResult {
        let request = GraphQLRequest(query: query, operationName: operationName, variables: variables)
        return try await execute(request: request)
    }

    @concurrent
    public func execute<Response: Decodable & Sendable>(
        request: GraphQLRequest,
        responseType: Response.Type = Response.self,
        requireNoErrors: Bool = true
    ) async throws -> Response {
        try await transport.graphQL(
            request: request,
            responseType: responseType,
            requireNoErrors: requireNoErrors
        )
    }

    @concurrent
    public func execute<Response: Decodable & Sendable>(
        query: String,
        operationName: String? = nil,
        variables: [String: Map] = [:],
        responseType: Response.Type = Response.self,
        requireNoErrors: Bool = true
    ) async throws -> Response {
        let request = GraphQLRequest(query: query, operationName: operationName, variables: variables)
        return try await execute(
            request: request,
            responseType: responseType,
            requireNoErrors: requireNoErrors
        )
    }

    @concurrent
    public func execute<Response: Decodable & Sendable, Variables: Encodable & Sendable>(
        query: String,
        operationName: String? = nil,
        variables: Variables,
        responseType: Response.Type = Response.self,
        requireNoErrors: Bool = true
    ) async throws -> Response {
        let request = try makeRequest(
            query: query,
            operationName: operationName,
            variables: variables
        )
        return try await execute(
            request: request,
            responseType: responseType,
            requireNoErrors: requireNoErrors
        )
    }

    @concurrent
    public func execute<Operation: SwikiGraphQLOperation>(
        operation: Operation,
        requireNoErrors: Bool = true
    ) async throws -> Operation.Data {
        try await execute(
            query: Operation.operationDocument,
            operationName: Operation.operationName,
            variables: operation.variables,
            responseType: Operation.Data.self,
            requireNoErrors: requireNoErrors
        )
    }

    @concurrent
    public func query(
        _ query: String,
        operationName: String? = nil,
        variables: [String: Map] = [:],
        requireNoErrors: Bool = true
    ) async throws -> GraphQLResult {
        let result = try await execute(query: query, operationName: operationName, variables: variables)
        try ensureNoErrorsIfNeeded(result, requireNoErrors: requireNoErrors)
        return result
    }

    @concurrent
    public func query<Variables: Encodable & Sendable>(
        _ query: String,
        operationName: String? = nil,
        variables: Variables,
        requireNoErrors: Bool = true
    ) async throws -> GraphQLResult {
        let result = try await execute(query: query, operationName: operationName, variables: variables)
        try ensureNoErrorsIfNeeded(result, requireNoErrors: requireNoErrors)
        return result
    }

    @concurrent
    public func mutation(
        _ query: String,
        operationName: String? = nil,
        variables: [String: Map] = [:],
        requireNoErrors: Bool = true
    ) async throws -> GraphQLResult {
        let result = try await execute(query: query, operationName: operationName, variables: variables)
        try ensureNoErrorsIfNeeded(result, requireNoErrors: requireNoErrors)
        return result
    }

    @concurrent
    public func mutation<Variables: Encodable & Sendable>(
        _ query: String,
        operationName: String? = nil,
        variables: Variables,
        requireNoErrors: Bool = true
    ) async throws -> GraphQLResult {
        let result = try await execute(query: query, operationName: operationName, variables: variables)
        try ensureNoErrorsIfNeeded(result, requireNoErrors: requireNoErrors)
        return result
    }

    private func makeRequest<Variables: Encodable & Sendable>(
        query: String,
        operationName: String?,
        variables: Variables
    ) throws -> GraphQLRequest {
        let map = try Map(variables)
        guard case let .dictionary(dictionary) = map else {
            throw SwikiGraphQLClientError.invalidVariablesPayload
        }

        let variables = Dictionary(uniqueKeysWithValues: dictionary.map { ($0.key, $0.value) })
        return GraphQLRequest(
            query: query,
            operationName: operationName,
            variables: variables
        )
    }

    private func ensureNoErrorsIfNeeded(
        _ result: GraphQLResult,
        requireNoErrors: Bool
    ) throws {
        guard requireNoErrors, !result.errors.isEmpty else {
            return
        }
        throw SwikiClientError.graphQLErrors(result.errors.map(\.message))
    }
}
