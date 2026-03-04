import Foundation
import SwikiModels

public struct SwikiV1FriendsClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1FriendsClient {

    /// POST ``/api/friends/:id``
    ///
    /// Create a friend
    /// - Note: Requires ``friends`` oauth scope
    @discardableResult
    func create(id: String) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .post, path: "friends", id: id)
    }

    /// DELETE ``/api/friends/:id``
    ///
    /// Destroy a friend
    /// - Note: Requires ``friends`` oauth scope
    @discardableResult
    func delete(id: String) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .delete, path: "friends", id: id)
    }

}
