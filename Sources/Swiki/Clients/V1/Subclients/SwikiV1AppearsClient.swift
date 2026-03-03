import Foundation
import SwikiModels

public struct SwikiV1AppearsClient: SwikiResourceSubclient {
    public typealias Model = SwikiAppear
    public let resourceClient: SwikiResourceClient<SwikiAppear>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "appears")
    }
}

public extension SwikiV1AppearsClient {
    func index(query: SwikiQuery = [:]) async throws -> [SwikiAppear] { try await list(query: query) }
}
