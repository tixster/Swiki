import Foundation
import SwikiModels

/// ``/api/characters``
public struct SwikiV1CharactersClient: SwikiResourceSubclient {
    public typealias Model = SwikiCharacter
    public let resourceClient: SwikiResourceClient<SwikiCharacter>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "characters")
    }
}

public extension SwikiV1CharactersClient {
    
    /// GET ``/api/characters/:id``
    ///
    /// Show a character
    func character(id: String) async throws -> SwikiCharacter {
        try await resourceClient.get(id: id)
    }
    
    /// GET ``/api/characters/search``
    ///
    /// Search characters
    func search(query: SwikiV1CharactersQuery) async throws -> [SwikiCharacterPreview] {
        try await request(.get, route: "search", query: query.asSwikiQuery)
    }
    
}
