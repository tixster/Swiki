import Foundation
import SwikiModels

public struct SwikiV1FavoritesClient: SwikiResourceSubclient {
    public typealias Model = SwikiFavorite
    public let resourceClient: SwikiResourceClient<SwikiFavorite>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "favorites")
    }
}

public extension SwikiV1FavoritesClient {
    func create(linkedType: String, linkedId: String, query: SwikiQuery = [:]) async throws -> SwikiFavorite {
        try await request(.post, id: linkedType, action: linkedId, query: query)
    }
    func delete(linkedType: String, linkedId: String, query: SwikiQuery = [:]) async throws {
        try await request(.delete, id: linkedType, action: linkedId, query: query)
    }
    func reorder(id: String, query: SwikiQuery = [:]) async throws {
        try await request(.post, id: id, action: "reorder", query: query)
    }
    func reorder<Body: Encodable>(id: String, body: Body, query: SwikiQuery = [:]) async throws {
        try await request(.post, id: id, action: "reorder", query: query, body: body)
    }
}
