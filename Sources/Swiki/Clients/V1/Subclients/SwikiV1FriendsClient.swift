import Foundation
import SwikiModels

public struct SwikiV1FriendsClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1FriendsClient {
    func create(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .post, path: "friends", id: id, query: query)
    }

    func delete(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .delete, path: "friends", id: id, query: query)
    }
}
