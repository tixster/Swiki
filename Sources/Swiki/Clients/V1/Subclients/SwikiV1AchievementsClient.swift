import Foundation
import SwikiModels

/// ``/api/achievements``
public struct SwikiV1AchievementsClient: SwikiResourceSubclient {
    public typealias Model = Achievement
    public let resourceClient: SwikiResourceClient<Achievement>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "achievements")
    }
}

public extension SwikiV1AchievementsClient {

    /// GET ``/api/achievements``
    ///
    /// List user achievements
    func list(query: SwikiV1AchievementsQuery) async throws -> [Achievement] {
        try await list(query: query.asSwikiQuery)
    }

}
