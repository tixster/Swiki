import Foundation
import SwikiModels

public struct SwikiV1WhoamiClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }

    public func get(query: SwikiQuery = [:]) async throws -> SwikiUserInfo {
        try await transport.request(
            version: .v1,
            method: .get,
            path: "users/whoami",
            query: query
        )
    }
}

public extension SwikiV1WhoamiClient {
    func whoami(query: SwikiQuery = [:]) async throws -> SwikiUserInfo { try await get(query: query) }
}
