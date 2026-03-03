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
    func info(id: String, query: SwikiV1UsersQuery = .init()) async throws -> SwikiUserInfo {
        try await request(.get, id: id, action: "info", query: query.asSwikiQuery)
    }
    func whoami(query: SwikiV1UsersQuery = .init()) async throws -> SwikiUserInfo {
        try await request(.get, action: "whoami", query: query.asSwikiQuery)
    }
    func signOut(query: SwikiV1UsersQuery = .init()) async throws {
        try await request(.get, action: "sign_out", query: query.asSwikiQuery)
    }
    func friends(id: String, query: SwikiV1UsersQuery = .init()) async throws -> [SwikiUser] {
        try await request(.get, id: id, action: "friends", query: query.asSwikiQuery)
    }
    func clubs(id: String, query: SwikiV1UsersQuery = .init()) async throws -> [SwikiClub] {
        try await request(.get, id: id, action: "clubs", query: query.asSwikiQuery)
    }
    func animeRates(id: String, query: SwikiV1UserRatesQuery = .init()) async throws -> [SwikiAnimeRate] {
        try await request(.get, id: id, action: "anime_rates", query: query.asSwikiQuery)
    }
    func mangaRates(id: String, query: SwikiV1UserRatesQuery = .init()) async throws -> [SwikiAnimeRate] {
        try await request(.get, id: id, action: "manga_rates", query: query.asSwikiQuery)
    }
    func favorites(id: String, query: SwikiV1UsersQuery = .init()) async throws -> SwikiUserFavorites {
        try await request(.get, id: id, action: "favourites", query: query.asSwikiQuery)
    }
    func favourites(id: String, query: SwikiV1UsersQuery = .init()) async throws -> SwikiUserFavorites {
        try await favorites(id: id, query: query)
    }
    func messages(id: String, query: SwikiV1MessagesQuery = .init()) async throws -> [SwikiMessage] {
        try await request(.get, id: id, action: "messages", query: query.asSwikiQuery)
    }
    func unreadMessages(id: String, query: SwikiV1MessagesQuery = .init()) async throws -> SwikiNewInformation {
        try await request(.get, id: id, action: "unread_messages", query: query.asSwikiQuery)
    }
    func history(id: String, query: SwikiV1HistoryQuery = .init()) async throws -> [SwikiUserHistory] {
        try await request(.get, id: id, action: "history", query: query.asSwikiQuery)
    }
    func bans(id: String, query: SwikiV1UsersQuery = .init()) async throws -> [SwikiBan] {
        try await request(.get, id: id, action: "bans", query: query.asSwikiQuery)
    }
}
