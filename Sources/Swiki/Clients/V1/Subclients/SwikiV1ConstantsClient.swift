import Foundation
import SwikiModels

/// ``/api/constants``
public struct SwikiV1ConstantsClient: SwikiResourceSubclient {
    public typealias Model = SwikiAnimeConstants
    public let resourceClient: SwikiResourceClient<SwikiAnimeConstants>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "constants")
    }
}

public extension SwikiV1ConstantsClient {

    /// GET ``/api/constants/anime``
    func anime() async throws -> SwikiAnimeConstants {
        try await request(.get, route: "anime")
    }

    /// GET ``/api/constants/manga``
    func manga() async throws -> SwikiMangaConstants {
        try await request(.get, route: "manga")
    }

    /// GET ``/api/constants/user_rate``
    func userRate() async throws -> SwikiUserRateConstants {
        try await request(.get, route: "user_rate")
    }

    /// GET ``/api/constants/club``
    func club() async throws -> SwikiClubConstants {
        try await request(.get, route: "club")
    }

    /// GET ``/api/constants/smileys``
    func smileys() async throws -> [SwikiSmileyConstant] {
        try await request(.get, route: "smileys")
    }

}
