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
    func anime() async throws -> SwikiAnimeConstants {
        try await request(.get, action: "anime")
    }

    func manga() async throws -> SwikiMangaConstants {
        try await request(.get, action: "manga")
    }

    func userRate() async throws -> SwikiUserRateConstants {
        try await request(.get, action: "user_rate")
    }

    func club() async throws -> SwikiClubConstants {
        try await request(.get, action: "club")
    }

    func smileys() async throws -> [SwikiSmileyConstant] {
        try await request(.get, action: "smileys")
    }
}
