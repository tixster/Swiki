import Foundation
import SwikiModels

public struct SwikiV1BansClient: SwikiResourceSubclient {
    public typealias Model = SwikiBan
    public let resourceClient: SwikiResourceClient<SwikiBan>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "bans")
    }
}

public extension SwikiV1BansClient {
    func index(query: SwikiQuery = [:]) async throws -> [SwikiBan] { try await list(query: query) }
}
