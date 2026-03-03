import Foundation
import SwikiModels

public struct SwikiV1IgnoresClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1IgnoresClient {
    func create(id: String) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .post, path: "ignores", id: id)
    }

    func delete(id: String) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .delete, path: "ignores", id: id)
    }
}
