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
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiClub] { try await list(query: query) }
    func get(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiClub { try await resourceClient.get(id: id, query: query) }
    func update<Body: Encodable>(id: String, body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiClub {
        try await resourceClient.update(id: id, body: body, query: query, method: .put)
    }
    func animes(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiAnimeV1Preview] {
        try await request(.get, id: id, action: "animes", query: query)
    }
    func mangas(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiManga] {
        try await request(.get, id: id, action: "mangas", query: query)
    }
    func ranobe(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiManga] {
        try await request(.get, id: id, action: "ranobe", query: query)
    }
    func characters(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiCharacter] {
        try await request(.get, id: id, action: "characters", query: query)
    }
    func members(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiUser] {
        try await request(.get, id: id, action: "members", query: query)
    }
    func images(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiClubImage] {
        try await request(.get, id: id, action: "images", query: query)
    }
    func join(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.post, id: id, action: "join", query: query)
    }
    func leave(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.post, id: id, action: "leave", query: query)
    }
}
