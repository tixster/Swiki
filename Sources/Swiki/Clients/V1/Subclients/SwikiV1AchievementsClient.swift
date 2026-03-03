import Foundation
import SwikiModels

public struct SwikiV1AchievementsClient: SwikiResourceSubclient {
    public typealias Model = Achievement
    public let resourceClient: SwikiResourceClient<Achievement>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "achievements")
    }
}

public extension SwikiV1AchievementsClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [Achievement] { try await list(query: query) }
}
