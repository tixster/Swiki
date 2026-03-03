import Foundation
import SwikiModels

public struct SwikiV1PublishersClient: SwikiResourceSubclient {
    public typealias Model = SwikiPublisher
    public let resourceClient: SwikiResourceClient<SwikiPublisher>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "publishers")
    }
}

public extension SwikiV1PublishersClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiPublisher] { try await list(query: query) }
    func get(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiPublisher { try await resourceClient.get(id: id, query: query) }
}
