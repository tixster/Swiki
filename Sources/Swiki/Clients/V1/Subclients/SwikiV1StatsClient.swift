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
    /// GET ``/api/stats/active_users``
    ///
    /// Users having at least 1 completed animes and active during last month
    func activeUsers() async throws -> [Int] {
        try await request(.get, route: "active_users")
    }
}
