import Foundation
import SwikiModels

public struct SwikiV1UsersClient: SwikiResourceSubclient {
    public typealias Model = SwikiUserPreview
    public let resourceClient: SwikiResourceClient<SwikiUserPreview>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "users")
    }
}

public extension SwikiV1UsersClient {
    
    /// GET ``/api/users``
    ///
    /// List users.
    func list(query: SwikiV1UsersSearchQuery = .init()) async throws -> [SwikiUserPreview] {
        try await request(.get, query: query.asSwikiQuery)
    }

    /// GET ``/api/users/:id``
    ///
    /// Show a user by id.
    func user(id: String) async throws -> SwikiUser {
        try await request(.get, id: id)
    }

    // GET ``/api/users/:id``
    ///
    /// Show a user by nickname.
    func user(nickname: String) async throws -> SwikiUser {
        try await request(.get, id: nickname, query: ["is_nickname ": "1"])
    }

    /// GET ``/api/users/:id/info``
    ///
    /// Show user's brief info
    func info(id: String) async throws -> SwikiUserInfo {
        try await request(.get, id: id, route: "info")
    }

    /// GET ``/api/users/whoami``
    ///
    /// Show current user's brief info
    func whoami() async throws -> SwikiUserInfo {
        try await request(.get, route: "whoami")
    }

    /// POST ``/api/users/sign_out``
    ///
    /// Sign out the user.
    func signOut() async throws {
        try await request(.post, route: "sign_out")
    }

    /// GET ``/api/users/:id/friends``
    ///
    /// Show user's friends
    func friends(id: String, query: SwikiV1UsersQuery = .init()) async throws -> [SwikiUserPreview] {
        try await request(.get, id: id, route: "friends", query: query.asSwikiQuery)
    }

    /// GET ``/api/users/:id/clubs``
    ///
    /// List user clubs.
    func clubs(id: String) async throws -> [SwikiClubPreview] {
        try await request(.get, id: id, route: "clubs")
    }

    /// GET ``/api/users/:id/anime_rates``
    ///
    /// Show user's anime list
    func animeRates(id: String, query: SwikiV1UsersRatesQuery = .init()) async throws -> [SwikiAnimeRate] {
        try await request(.get, id: id, route: "anime_rates", query: query.asSwikiQuery)
    }

    /// GET ``/api/users/:id/manga_rates``
    ///
    /// Show user's manga list
    func mangaRates(id: String, query: SwikiV1UsersRatesQuery = .init()) async throws -> [SwikiAnimeRate] {
        try await request(.get, id: id, route: "manga_rates", query: query.asSwikiQuery)
    }

    /// GET ``/api/users/:id/favourites``
    ///
    /// Show user's favourites
    func favorites(id: String) async throws -> SwikiUserFavorites {
        try await request(.get, id: id, route: "favourites")
    }

    /// GET ``/api/users/:id/messages``
    ///
    /// List user messages.
    ///
    /// - Note: Requires `messages` oauth scope
    func messages(id: String, query: SwikiV1UserMessagesQuery = .init()) async throws -> [SwikiMessage] {
        try await request(.get, id: id, route: "messages", query: query.asSwikiQuery)
    }

    /// GET ``/api/users/:id/unread_messages``
    ///
    /// Show current user's unread messages counts
    ///
    /// - Note: Requires `messages` oauth scope
    func unreadMessages(id: String) async throws -> SwikiUnreadMessagesInformation {
        try await request(.get, id: id, route: "unread_messages")
    }

    /// GET ``/api/users/:id/history``
    ///
    /// Get user history.
    func history(id: String, query: SwikiV1HistoryQuery = .init()) async throws -> [SwikiUserHistory] {
        try await request(.get, id: id, route: "history", query: query.asSwikiQuery)
    }

    /// GET ``/api/users/:id/bans``
    ///
    /// Get user bans.
    func bans(id: String) async throws -> [SwikiBan] {
        try await request(.get, id: id, route: "bans")
    }
}
