import Foundation
import SwikiModels

public struct SwikiV1FriendsClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1FriendsClient {
    func create(id: String) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .post, path: "friends", id: id)
    }

    func delete(id: String) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .delete, path: "friends", id: id)
    }
}
