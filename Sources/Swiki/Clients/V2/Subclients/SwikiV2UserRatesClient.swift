import Foundation
import SwikiModels

public struct SwikiV2UserRatesClient: SwikiResourceSubclient {
    public typealias Model = SwikiUserRate
    public let resourceClient: SwikiResourceClient<SwikiUserRate>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "user_rates")
    }
}

public extension SwikiV2UserRatesClient {
    func index(query: SwikiQuery = [:]) async throws -> [SwikiUserRate] {
        try await list(query: query)
    }

    func get(id: String, query: SwikiQuery = [:]) async throws -> SwikiUserRate {
        try await resourceClient.get(id: id, query: query)
    }

    func create<Body: Encodable>(body: Body, query: SwikiQuery = [:]) async throws -> SwikiUserRate {
        try await resourceClient.create(body: body, query: query)
    }

    func update<Body: Encodable>(
        id: String,
        body: Body,
        query: SwikiQuery = [:],
        method: SwikiHTTPMethod = .put
    ) async throws -> SwikiUserRate {
        try await resourceClient.update(id: id, body: body, query: query, method: method)
    }

    func delete(id: String, query: SwikiQuery = [:]) async throws {
        try await resourceClient.delete(id: id, query: query)
    }

    func increment(id: String, query: SwikiQuery = [:]) async throws -> SwikiUserRate {
        try await request(.get, id: id, action: "increment", query: query)
    }
}
