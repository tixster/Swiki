import Foundation
import SwikiModels

public struct SwikiV1AppearsClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1AppearsClient {
    func create(ids: [String], query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        var merged = query.asSwikiQuery
        if !ids.isEmpty {
            merged["ids"] = ids.joined(separator: ",")
        }
        try await transport.request(version: .v1, method: .post, path: "appears", query: merged)
    }

    func markRead(ids: [String], query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await create(ids: ids, query: query)
    }
}
