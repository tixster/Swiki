import Foundation
import SwikiModels

public struct SwikiV1FriendsClient: SwikiResourceSubclient {
    public typealias Model = SwikiFriend
    public let resourceClient: SwikiResourceClient<SwikiFriend>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "friends")
    }
}

public extension SwikiV1FriendsClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiFriend] { try await list(query: query) }
    func create(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiFriend {
        try await request(.post, id: id, query: query)
    }
    func delete(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.delete, id: id, query: query)
    }
}
