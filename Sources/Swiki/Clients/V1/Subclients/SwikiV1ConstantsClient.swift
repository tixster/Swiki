import Foundation
import SwikiModels

public struct SwikiV1ConstantsClient: SwikiResourceSubclient {
    public typealias Model = SwikiAnimeConstants
    public let resourceClient: SwikiResourceClient<SwikiAnimeConstants>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "constants")
    }
}

public extension SwikiV1ConstantsClient {
    func anime(query: SwikiQuery = [:]) async throws -> SwikiAnimeConstants {
        try await request(.get, action: "anime", query: query)
    }

    func manga(query: SwikiQuery = [:]) async throws -> SwikiMangaConstants {
        try await request(.get, action: "manga", query: query)
    }

    func userRate(query: SwikiQuery = [:]) async throws -> SwikiUserRateConstants {
        try await request(.get, action: "user_rate", query: query)
    }

    func club(query: SwikiQuery = [:]) async throws -> SwikiClubConstants {
        try await request(.get, action: "club", query: query)
    }

    func smileys(query: SwikiQuery = [:]) async throws -> [SwikiSmileyConstant] {
        try await request(.get, action: "smileys", query: query)
    }
}
