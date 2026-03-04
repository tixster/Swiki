import Foundation
import SwikiModels

public struct SwikiV1IgnoresClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1IgnoresClient {

    /// POST /api/ignores/:id DEPRECATED
    ///
    /// Create an ignore
    ///
    /// - Note: Requires ``ignores`` oauth scope
    @available(*, deprecated, message: "API DEPREACATED")
    @discardableResult
    func create(userId: String) async throws -> SwikiNoticeResponse {
        try await transport.request(
            version: .v1,
            method: .post,
            path: "ignores",
            id: userId
        )
    }

    /// DELET /api/ignores/:id DEPRECATED
    ///
    /// Destroy an ignore
    ///
    /// - Note: Requires ``ignores`` oauth scope
    @discardableResult
    @available(*, deprecated, message: "API DEPREACATED")
    func delete(userId: String) async throws -> SwikiNoticeResponse {
        try await transport
            .request(
                version: .v1,
                method: .delete,
                path: "ignores",
                id: userId
            )
    }

}
