import Foundation
import SwikiModels

public struct SwikiV2UserIgnoreClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV2UserIgnoreClient {
    func create(userId: String) async throws -> SwikiUserIgnore {
        try await transport.request(version: .v2, method: .post, path: "users", id: userId, route: "ignore")
    }

    func delete(userId: String) async throws -> SwikiUserIgnore {
        try await transport.request(version: .v2, method: .delete, path: "users", id: userId, route: "ignore")
    }
}
