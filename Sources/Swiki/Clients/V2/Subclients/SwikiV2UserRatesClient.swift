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

    func get(id: String) async throws -> SwikiUserRate {
        try await resourceClient.get(id: id)
    }

    func create<Body: Encodable>(body: Body) async throws -> SwikiUserRate {
        try await resourceClient.create(body: body)
    }

    func update<Body: Encodable>(
        id: String,
        body: Body,
        method: SwikiHTTPMethod = .put
    ) async throws -> SwikiUserRate {
        try await resourceClient.update(id: id, body: body, method: method)
    }

    func delete(id: String) async throws {
        try await resourceClient.delete(id: id)
    }

    func increment(id: String) async throws -> SwikiUserRate {
        try await request(.post, id: id, route: "increment")
    }
}
