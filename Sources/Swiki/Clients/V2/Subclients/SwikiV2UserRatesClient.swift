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
    func get(query: SwikiV2UserRatesQuery = .init()) async throws -> [SwikiUserRate] {
        try await list(query: query.asSwikiQuery)
    }

    func get(id: String, query: SwikiV2UserRatesQuery = .init()) async throws -> SwikiUserRate {
        try await resourceClient.get(id: id, query: query.asSwikiQuery)
    }

    func create<Body: Encodable>(body: Body, query: SwikiV2UserRatesQuery = .init()) async throws -> SwikiUserRate {
        try await resourceClient.create(body: body, query: query.asSwikiQuery)
    }

    func update<Body: Encodable>(
        id: String,
        body: Body,
        query: SwikiV2UserRatesQuery = .init(),
        method: SwikiHTTPMethod = .put
    ) async throws -> SwikiUserRate {
        try await resourceClient.update(id: id, body: body, query: query.asSwikiQuery, method: method)
    }

    func delete(id: String, query: SwikiV2UserRatesQuery = .init()) async throws {
        try await resourceClient.delete(id: id, query: query.asSwikiQuery)
    }

    func increment(id: String, query: SwikiV2UserRatesQuery = .init()) async throws -> SwikiUserRate {
        try await request(.get, id: id, action: "increment", query: query.asSwikiQuery)
    }
}
