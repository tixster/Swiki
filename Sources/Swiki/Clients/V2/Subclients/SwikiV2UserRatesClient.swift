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
    /// GET ``/api/v2/user_rates``
    ///
    /// List user rates.
    func get(query: SwikiV2UserRatesQuery = .init()) async throws -> [SwikiUserRate] {
        try await list(query: query.asSwikiQuery)
    }

    /// GET ``/api/v2/user_rates/:id``
    ///
    /// Show a user rate.
    func get(id: String) async throws -> SwikiUserRate {
        try await resourceClient.get(id: id)
    }

    /// POST ``/api/v2/user_rates``
    ///
    /// Create a user rate.
    func create<Body: Encodable>(body: Body) async throws -> SwikiUserRate {
        try await resourceClient.create(body: body)
    }

    /// PUT ``/api/v2/user_rates/:id``
    ///
    /// Update a user rate.
    func update<Body: Encodable>(
        id: String,
        body: Body,
        method: SwikiHTTPMethod = .put
    ) async throws -> SwikiUserRate {
        try await resourceClient.update(id: id, body: body, method: method)
    }

    /// DELETE ``/api/v2/user_rates/:id``
    ///
    /// Delete a user rate.
    func delete(id: String) async throws {
        try await resourceClient.delete(id: id)
    }

    /// POST ``/api/v2/user_rates/:id/increment``
    ///
    /// Increment user rate progress.
    func increment(id: String) async throws -> SwikiUserRate {
        try await request(.post, id: id, route: "increment")
    }
}
