import Foundation
import SwikiModels

public struct SwikiV1RanobeClient: SwikiResourceSubclient {
    public typealias Model = SwikiRanobeV1
    public let resourceClient: SwikiResourceClient<SwikiRanobeV1>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "ranobe")
    }
}

public extension SwikiV1RanobeClient {

    /// GET ``/api/ranobe``
    ///
    /// List ranobe.
    func list(query: SwikiV1RanobeSearchQuery = .init()) async throws -> [SwikiRanobeV1Preview] {
        try await request(.get, query: query.asSwikiQuery)
    }

    /// GET ``/api/ranobe/:id``
    ///
    /// Show ranobe details.
    func get(id: String) async throws -> SwikiRanobeV1 { try await resourceClient.get(id: id) }

    /// GET ``/api/ranobe/:id/roles``
    ///
    /// Get ranobe roles.
    func roles(id: String) async throws -> [SwikiRole] {
        try await request(.get, id: id, route: "roles")
    }

    /// GET ``/api/ranobe/:id/similar``
    ///
    /// Get similar ranobe.
    func similar(id: String) async throws -> [SwikiRanobeV1Preview] {
        try await request(.get, id: id, route: "similar")
    }

    /// GET ``/api/ranobe/:id/related``
    ///
    /// Get related titles.
    func related(id: String) async throws -> [SwikiRelated] {
        try await request(.get, id: id, route: "related")
    }

    /// GET ``/api/ranobe/:id/franchise``
    ///
    /// Get ranobe franchise data.
    func franchise(id: String) async throws -> SwikiFranchise {
        try await request(.get, id: id, route: "franchise")
    }

    /// GET ``/api/ranobe/:id/external_links``
    ///
    /// Get ranobe external links.
    func externalLinks(id: String) async throws -> [SwikiExternalLink] {
        try await request(.get, id: id, route: "external_links")
    }

    /// GET ``/api/ranobe/:id/topics``
    ///
    /// Get ranobe topics.
    func topics(id: String, query: SwikiV1RanobeQuery = .init()) async throws -> [SwikiTopic] {
        try await request(.get, id: id, route: "topics", query: query.asSwikiQuery)
    }

}
