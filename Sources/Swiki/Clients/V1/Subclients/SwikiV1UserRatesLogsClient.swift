import Foundation
import SwikiModels

public struct SwikiV1UserRatesLogsClient: SwikiResourceSubclient {
    public typealias Model = SwikiUserRateLog
    public let resourceClient: SwikiResourceClient<SwikiUserRateLog>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "user_rates_logs")
    }
}

public extension SwikiV1UserRatesLogsClient {
    func get(query: SwikiQuery = [:]) async throws -> [SwikiUserRateLog] { try await list(query: query) }
}
