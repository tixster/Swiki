import Foundation
import SwikiModels

/// ``/api/animes``
public struct SwikiV1AnimesClient: SwikiResourceSubclient {
    public typealias Model = SwikiAnimeV1
    public let resourceClient: SwikiResourceClient<SwikiAnimeV1>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "animes")
    }
}

public extension SwikiV1AnimesClient {

    /// GET ``/api/animes``
    ///
    /// List animes
    func list(query: SwikiV1AnimesQuery = .init()) async throws -> [SwikiAnimeV1Preview] {
        try await request(
            .get,
            query: query.asSwikiQuery
        )
    }

    /// GET ``/api/animes/:id``
    ///
    /// Show an anime
    func anime(id: String) async throws -> SwikiAnimeV1 {
        try await resourceClient.get(id: id)
    }

    /// GET ``/api/animes/:id/roles``
    func roles(id: String) async throws -> [SwikiRole] {
        try await request(
            .get,
            id: id,
            route: "roles"
        )
    }

    /// GET ``/api/animes/:id/similar``
    func similar(id: String) async throws -> [SwikiAnimeV1Preview] {
        try await request(
            .get,
            id: id,
            route: "similar"
        )
    }

    /// GET ``/api/animes/:id/related``
    func related(id: String) async throws -> [SwikiRelated] {
        try await request(
            .get,
            id: id,
            route: "related"
        )
    }

    /// GET ``/api/animes/:id/screenshots``
    func screenshots(id: String) async throws -> [SwikiImage] {
        try await request(
            .get,
            id: id,
            route: "screenshots"
        )
    }

    /// GET ``/api/animes/:id/videos``
    ///
    /// Use Videos API instead
    @available(*, deprecated, renamed: "SwikiV1VideosClient.get(animeId:)", message: "Use Videos API instead")
    func videos(id: String) async throws -> [SwikiVideo] {
        try await request(
            .get,
            id: id,
            route: "franchise"
        )
    }

    /// GET ``/api/animes/:id/franchise``
    func franchise(id: String) async throws -> SwikiFranchise {
        try await request(
            .get,
            id: id,
            route: "franchise"
        )
    }

    /// GET ``/api/animes/:id/external_links``
    func externalLinks(id: String) async throws -> [SwikiExternalLink] {
        try await request(
            .get,
            id: id,
            route: "external_links"
        )
    }

    /// GET ``/api/animes/search``
    @available(*, deprecated, renamed: "list(query:)", message: "Use List animes API instead")
    func search(_ search: String) async throws -> [SwikiAnimeV1Preview] {
        try await request(
            .get,
            route: "search",
            query: ["search": search]
        )
    }

    /// GET ``/api/animes/:id/topics``
    func topics(id: String, query: SwikiV1AnimesTopicsQuery = .init()) async throws -> [SwikiTopic] {
        try await request(
            .get,
            id: id,
            route: "topics",
            query: query.asSwikiQuery
        )
    }

}
