import Foundation
import SwikiModels

public struct SwikiV1UserRatesClient: SwikiResourceSubclient {
    public typealias Model = SwikiUserRate
    public let resourceClient: SwikiResourceClient<SwikiUserRate>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "user_rates")
    }
}

public extension SwikiV1UserRatesClient {

    /// DELETE ``/api/user_rates/:type/cleanup``
    ///
    /// Delete entire user rates and history
    ///
    /// - Note: Requires ``user_rates`` oauth scope
    func cleanup(type: SwikiUserRatesType) async throws {
        try await request(.delete, id: type.rawValue, route: "cleanup")
    }

    /// DELETE ``/api/user_rates/:type/reset``
    ///
    /// Reset all user scores to 0
    ///
    /// - Note: Requires ``user_rates`` oauth scope
    func reset(type: SwikiUserRatesType) async throws {
        try await request(.delete, id: type.rawValue, route: "reset")
    }

}
