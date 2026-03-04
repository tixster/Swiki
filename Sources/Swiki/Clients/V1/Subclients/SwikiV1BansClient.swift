import Foundation
import SwikiModels

/// ``/api/bans``
public struct SwikiV1BansClient: SwikiResourceSubclient {
    public typealias Model = SwikiBan
    public let resourceClient: SwikiResourceClient<SwikiBan>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "bans")
    }
}

public extension SwikiV1BansClient {
    
    /// GET ``/api/bans``
    ///
    /// List bans
    func list(
        query: SwikiQuery = [:]
    ) async throws -> [SwikiBan] {
        try await resourceClient.list(query: query)
    }

}
