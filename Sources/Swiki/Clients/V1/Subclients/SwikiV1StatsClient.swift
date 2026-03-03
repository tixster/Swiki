import Foundation
import SwikiModels

public struct SwikiV1StatsClient: SwikiResourceSubclient {
    public typealias Model = SwikiStats
    public let resourceClient: SwikiResourceClient<SwikiStats>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "stats")
    }
}

public extension SwikiV1StatsClient {
    func activeUsers(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [Int] {
        try await request(.get, action: "active_users", query: query)
    }
}
