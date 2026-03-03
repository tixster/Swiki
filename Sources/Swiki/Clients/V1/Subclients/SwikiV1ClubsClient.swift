import Foundation
import SwikiModels

public struct SwikiV1ClubsClient: SwikiResourceSubclient {
    public typealias Model = SwikiClub
    public let resourceClient: SwikiResourceClient<SwikiClub>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "clubs")
    }
}

public extension SwikiV1ClubsClient {
    func get(query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiClub] { try await list(query: query.asSwikiQuery) }
    func get(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> SwikiClub { try await resourceClient.get(id: id, query: query.asSwikiQuery) }
    func update<Body: Encodable>(id: String, body: Body, query: SwikiV1ClubsQuery = .init()) async throws -> SwikiClub {
        try await resourceClient.update(id: id, body: body, query: query.asSwikiQuery, method: .put)
    }
    func animes(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiAnimeV1Preview] {
        try await request(.get, id: id, action: "animes", query: query.asSwikiQuery)
    }
    func mangas(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiManga] {
        try await request(.get, id: id, action: "mangas", query: query.asSwikiQuery)
    }
    func ranobe(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiManga] {
        try await request(.get, id: id, action: "ranobe", query: query.asSwikiQuery)
    }
    func characters(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiCharacter] {
        try await request(.get, id: id, action: "characters", query: query.asSwikiQuery)
    }
    func members(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiUser] {
        try await request(.get, id: id, action: "members", query: query.asSwikiQuery)
    }
    func images(id: String, query: SwikiV1ClubsQuery = .init()) async throws -> [SwikiClubImage] {
        try await request(.get, id: id, action: "images", query: query.asSwikiQuery)
    }
    func join(id: String, query: SwikiV1ClubsQuery = .init()) async throws {
        try await request(.post, id: id, action: "join", query: query.asSwikiQuery)
    }
    func leave(id: String, query: SwikiV1ClubsQuery = .init()) async throws {
        try await request(.post, id: id, action: "leave", query: query.asSwikiQuery)
    }
}
