import Foundation
import SwikiModels

public struct SwikiV1IgnoresClient: SwikiResourceSubclient {
    public typealias Model = SwikiIgnore
    public let resourceClient: SwikiResourceClient<SwikiIgnore>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "ignores")
    }
}

public extension SwikiV1IgnoresClient {
    func index(query: SwikiQuery = [:]) async throws -> [SwikiIgnore] { try await list(query: query) }
    func create(id: String, query: SwikiQuery = [:]) async throws -> SwikiIgnore {
        try await request(.post, id: id, query: query)
    }
    func delete(id: String, query: SwikiQuery = [:]) async throws {
        try await request(.delete, id: id, query: query)
    }
}
