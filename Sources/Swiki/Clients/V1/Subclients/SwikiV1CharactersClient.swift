import Foundation
import SwikiModels

public struct SwikiV1CharactersClient: SwikiResourceSubclient {
    public typealias Model = SwikiCharacter
    public let resourceClient: SwikiResourceClient<SwikiCharacter>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "characters")
    }
}

public extension SwikiV1CharactersClient {
    func get(query: SwikiV1CharactersQuery) async throws -> [SwikiCharacter] { try await list(query: query.asSwikiQuery) }
    func get(id: String, query: SwikiQuery = [:]) async throws -> SwikiCharacter { try await resourceClient.get(id: id, query: query) }
}
