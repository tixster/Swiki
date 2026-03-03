import Foundation
import SwikiModels

public struct SwikiV1CollectionsClient: SwikiResourceSubclient {
    public typealias Model = SwikiCollection
    public let resourceClient: SwikiResourceClient<SwikiCollection>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "collections")
    }
}

public extension SwikiV1CollectionsClient {
    func index(query: SwikiQuery = [:]) async throws -> [SwikiCollection] { try await list(query: query) }
    func get(id: String, query: SwikiQuery = [:]) async throws -> SwikiCollection { try await resourceClient.get(id: id, query: query) }
}
