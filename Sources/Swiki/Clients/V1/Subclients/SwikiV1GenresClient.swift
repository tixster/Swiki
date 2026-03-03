import Foundation
import SwikiModels

public struct SwikiV1GenresClient: SwikiResourceSubclient {
    public typealias Model = SwikiGenre
    public let resourceClient: SwikiResourceClient<SwikiGenre>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "genres")
    }
}

public extension SwikiV1GenresClient {
    func index(query: SwikiQuery = [:]) async throws -> [SwikiGenre] { try await list(query: query) }
}
