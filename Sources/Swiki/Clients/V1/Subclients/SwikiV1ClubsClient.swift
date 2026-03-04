import Foundation
import SwikiModels

/// ``/api/clubs``
public struct SwikiV1ClubsClient: SwikiResourceSubclient {
    public typealias Model = SwikiClub
    public let resourceClient: SwikiResourceClient<SwikiClub>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "clubs")
    }
}

public extension SwikiV1ClubsClient {

    /// GET ``/api/clubs``
    ///
    /// List clubs
    func list(query: SwikiV1ClubsSearchQuery = .init()) async throws -> [SwikiClubPreview] {
        try await request(.get, query: query.asSwikiQuery)
    }

    /// GET ``/api/clubs/:id``
    ///
    /// Show a club
    func club(id: String) async throws -> SwikiClub {
        try await resourceClient.get(id: id)
    }

    /// PUT ``/api/clubs/:id``
    ///
    /// - Note: Requires ``clubs`` oauth scope
    @discardableResult
    func update(id: String, club: SwikiClubUpdatePayload) async throws -> SwikiClub {
        try await resourceClient.update(id: id, body: SwikiClubUpdateBody(club: club), method: .put)
    }

    /// GET ``/api/clubs/:id/animes``
    ///
    /// Show club's animes
    func animes(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiAnimeV1Preview] {
        try await request(.get, id: id, route: "animes", query: query.asSwikiQuery)
    }

    /// GET ``/api/clubs/:id/mangas``
    ///
    /// Show club's mangas
    func mangas(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiMangaV1Preview] {
        try await request(.get, id: id, route: "mangas", query: query.asSwikiQuery)
    }

    /// GET ``/api/clubs/:id/ranobe``
    ///
    /// Show club's ranobe
    func ranobe(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiMangaV1Preview] {
        try await request(.get, id: id, route: "ranobe", query: query.asSwikiQuery)
    }

    /// GET ``/api/clubs/:id/characters``
    ///
    /// Show club's characters
    func characters(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiCharacterPreview] {
        try await request(.get, id: id, route: "characters", query: query.asSwikiQuery)
    }

    /// GET ``/api/clubs/:id/collections``
    ///
    /// Show club's collections
    func collections(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiCollection] {
        try await request(.get, id: id, route: "collections", query: query.asSwikiQuery)
    }

    /// GET ``/api/clubs/:id/clubs``
    ///
    /// Show clubs in club characters
    func subСlubs(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiClubPreview] {
        try await request(.get, id: id, route: "clubs", query: query.asSwikiQuery)
    }

    /// GET ``/api/clubs/:id/members``
    ///
    /// Show club's members
    func members(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiUserPreview] {
        try await request(.get, id: id, route: "members", query: query.asSwikiQuery)
    }

    /// GET ``/api/clubs/:id/images``
    ///
    /// Show club's images
    func images(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiClubImage] {
        try await request(.get, id: id, route: "images", query: query.asSwikiQuery)
    }

    /// POST ``/api/clubs/:id/join``
    ///
    /// Join a club
    ///
    /// - note: Requires ``clubs`` oauth scope
    func join(id: String) async throws {
        try await request(.post, id: id, route: "join")
    }

    /// POST ``/api/clubs/:id/leave``
    ///
    /// Leave a club
    ///
    /// - note: Requires ``clubs`` oauth scope
    func leave(id: String) async throws {
        try await request(.post, id: id, route: "leave")
    }

}
