import Foundation
import SwikiModels

public struct SwikiV1WhoamiClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }

    public func get() async throws -> SwikiUserInfo {
        try await transport.request(
            version: .v1,
            method: .get,
            path: "users/whoami"
        )
    }
}

public extension SwikiV1WhoamiClient {
    func whoami() async throws -> SwikiUserInfo { try await get() }
}
