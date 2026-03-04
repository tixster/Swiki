import Foundation
import SwikiModels

/// ``/api/genres``
public struct SwikiV1GenresClient: SwikiResourceSubclient {
    public typealias Model = SwikiGenre
    public let resourceClient: SwikiResourceClient<SwikiGenre>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "genres")
    }
}

public extension SwikiV1GenresClient {

    /// GET ``/api/genres``
    ///
    /// List genres
    func list() async throws -> [SwikiGenre] {
        try await resourceClient.list()
    }

}
