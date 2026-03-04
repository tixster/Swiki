import Foundation
import SwikiModels

/// ``/api/appears``
public struct SwikiV1AppearsClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1AppearsClient {

    /// POST ``/api/appears``
    /// 
    /// Mark comments or topics as read
    /// - Parameters:
    ///   - ids: Comment & Topic ids
    ///   - query: query
    func markAsRead(ids: [String], query: SwikiQuery = [:]) async throws {
        struct Ids: Encodable {
            let ids: [String]
        }
        try await transport.request(
            version: .v1,
            method: .post,
            path: "appears",
            query: query,
            body: Ids(ids: ids)
        )
    }

}
