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
    @concurrent
    func list(query: SwikiV2UserRatesQuery = .init()) async throws -> [SwikiUserRate] {
        try await resourceClient.list(query: query.asSwikiQuery)
    }

    /// GET ``/api/v2/user_rates/:id``
    ///
    /// Show a user rate.
    @concurrent
    func get(id: String) async throws -> SwikiUserRate {
        try await resourceClient.get(id: id)
    }

    /// POST ``/api/v2/user_rates``
    ///
    /// Create a user rate.
    ///
    /// - Note: Requires `user_rates` oauth scope
    @concurrent
    @discardableResult
    func create(userRate: SwikiUserRatesCreatePayload) async throws -> SwikiUserRate {
        try await resourceClient.create(body: SwikiUserRatesCreatePayloadBody(userRate: userRate))
    }

    /// PUT ``/api/v2/user_rates/:id``
    ///
    /// Update a user rate.
    ///
    /// - Note: Requires `user_rates` oauth scope
    @concurrent
    @discardableResult
    func update(
        id: String,
        userRate: SwikiUserRatesUpdatePayload,
    ) async throws -> SwikiUserRate {
        try await resourceClient
            .update(
                id: id,
                body: SwikiUserRatesUpdatePayloadBody(userRate: userRate),
                method: .put
            )
    }

    /// POST ``/api/v2/user_rates/:id/increment``
    ///
    /// Increment episodes/chapters by 1
    ///
    /// - Note: Requires `user_rates` oauth scope
    @concurrent
    @discardableResult
    func increment(id: String) async throws -> SwikiUserRate {
        try await request(.post, id: id, route: "increment")
    }

    /// DELETE ``/api/v2/user_rates/:id``
    ///
    /// Delete a user rate.
    ///
    /// - Note: Requires `user_rates` oauth scope
    @concurrent
    func delete(id: String) async throws {
        try await resourceClient.delete(id: id)
    }

}
