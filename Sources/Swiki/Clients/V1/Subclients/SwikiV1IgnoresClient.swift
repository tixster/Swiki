import Foundation
import SwikiModels

public struct SwikiV1IgnoresClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1IgnoresClient {
    func create(id: String, query: SwikiQuery = [:]) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .post, path: "ignores", id: id, query: query)
    }

    func delete(id: String, query: SwikiQuery = [:]) async throws -> SwikiNoticeResponse {
        try await transport.request(version: .v1, method: .delete, path: "ignores", id: id, query: query)
    }
}
