import Foundation
import SwikiModels

public struct SwikiV1ForumsClient: SwikiResourceSubclient {
    public typealias Model = SwikiForum
    public let resourceClient: SwikiResourceClient<SwikiForum>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "forums")
    }
}

public extension SwikiV1ForumsClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiForum] { try await list(query: query) }
}
