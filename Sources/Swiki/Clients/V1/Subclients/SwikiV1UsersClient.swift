import Foundation
import SwikiModels

public struct SwikiV1UsersClient: SwikiResourceSubclient {
    public typealias Model = SwikiUser
    public let resourceClient: SwikiResourceClient<SwikiUser>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "users")
    }
}

public extension SwikiV1UsersClient {
    func get(query: SwikiV1UsersQuery = .init()) async throws -> [SwikiUser] {
        try await request(.get, query: query.asSwikiQuery)
    }
    func get(id: String, query: SwikiV1UsersQuery = .init()) async throws -> SwikiUserId {
        try await request(.get, id: id, query: query.asSwikiQuery)
    }
    func showByNickname(_ nickname: String, query: SwikiV1UsersQuery = .init()) async throws -> SwikiUserId {
        var merged = query.asSwikiQuery
        merged["is_nickname"] = "1"
        return try await request(.get, id: nickname, query: merged)
    }
    func info(id: String) async throws -> SwikiUserInfo {
        try await request(.get, id: id, action: "info")
    }
    func whoami() async throws -> SwikiUserInfo {
        try await request(.get, action: "whoami")
    }
    func signOut() async throws {
        try await request(.get, action: "sign_out")
    }
    func friends(id: String, query: SwikiV1UsersQuery = .init()) async throws -> [SwikiUser] {
        try await request(.get, id: id, action: "friends", query: query.asSwikiQuery)
    }
    func clubs(id: String) async throws -> [SwikiClub] {
        try await request(.get, id: id, action: "clubs")
    }
    func animeRates(id: String, query: SwikiV1UserRatesQuery = .init()) async throws -> [SwikiAnimeRate] {
        try await request(.get, id: id, action: "anime_rates", query: query.asSwikiQuery)
    }
    func mangaRates(id: String, query: SwikiV1UserRatesQuery = .init()) async throws -> [SwikiAnimeRate] {
        try await request(.get, id: id, action: "manga_rates", query: query.asSwikiQuery)
    }
    func favorites(id: String) async throws -> SwikiUserFavorites {
        try await request(.get, id: id, action: "favourites")
    }
    func favourites(id: String) async throws -> SwikiUserFavorites {
        try await favorites(id: id)
    }
    func messages(id: String, query: SwikiV1MessagesQuery = .init()) async throws -> [SwikiMessage] {
        try await request(.get, id: id, action: "messages", query: query.asSwikiQuery)
    }
    func unreadMessages(id: String) async throws -> SwikiNewInformation {
        try await request(.get, id: id, action: "unread_messages")
    }
    func history(id: String, query: SwikiV1HistoryQuery = .init()) async throws -> [SwikiUserHistory] {
        try await request(.get, id: id, action: "history", query: query.asSwikiQuery)
    }
    func bans(id: String) async throws -> [SwikiBan] {
        try await request(.get, id: id, action: "bans")
    }
}
