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
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiUser] {
        try await request(.get, query: query)
    }
    func get(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiUserId {
        try await request(.get, id: id, query: query)
    }
    func showByNickname(_ nickname: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiUserId {
        var merged = query.asSwikiQuery
        merged["is_nickname"] = "1"
        return try await request(.get, id: nickname, query: merged)
    }
    func info(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiUserInfo {
        try await request(.get, id: id, action: "info", query: query)
    }
    func whoami(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiUserInfo {
        try await request(.get, action: "whoami", query: query)
    }
    func signOut(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.get, action: "sign_out", query: query)
    }
    func friends(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiUser] {
        try await request(.get, id: id, action: "friends", query: query)
    }
    func clubs(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiClub] {
        try await request(.get, id: id, action: "clubs", query: query)
    }
    func animeRates(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiAnimeRate] {
        try await request(.get, id: id, action: "anime_rates", query: query)
    }
    func mangaRates(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiAnimeRate] {
        try await request(.get, id: id, action: "manga_rates", query: query)
    }
    func favorites(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiUserFavorites {
        try await request(.get, id: id, action: "favourites", query: query)
    }
    func favourites(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiUserFavorites {
        try await favorites(id: id, query: query)
    }
    func messages(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiMessage] {
        try await request(.get, id: id, action: "messages", query: query)
    }
    func unreadMessages(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiNewInformation {
        try await request(.get, id: id, action: "unread_messages", query: query)
    }
    func history(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiUserHistory] {
        try await request(.get, id: id, action: "history", query: query)
    }
    func bans(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiBan] {
        try await request(.get, id: id, action: "bans", query: query)
    }
}
