import Foundation
import SwikiModels

/// ``/api/mangas``
public struct SwikiV1MangasClient: SwikiResourceSubclient {
    public typealias Model = SwikiMangaV1
    public let resourceClient: SwikiResourceClient<SwikiMangaV1>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "mangas")
    }
}

public extension SwikiV1MangasClient {

    /// GET ``/api/mangas``
    ///
    /// List mangas
    func list(query: SwikiV1MangasQuery = .init()) async throws -> [SwikiMangaV1Preview] {
        try await request(.get, query: query.asSwikiQuery)
    }

    /// GET ``/api/mangas/:id``
    ///
    /// Show a manga
    func manga(id: String) async throws -> SwikiMangaV1 {
        try await resourceClient.get(id: id)
    }

    /// GET ``/api/mangas/:id/roles``
    func roles(id: String) async throws -> [SwikiRole] {
        try await request(.get, id: id, route: "roles")
    }

    /// GET ``/api/mangas/:id/similar``
    func similar(id: String) async throws -> [SwikiMangaV1Preview] {
        try await request(.get, id: id, route: "similar")
    }

    /// GET ``/api/mangas/:id/related``
    func related(id: String) async throws -> [SwikiRelated] {
        try await request(.get, id: id, route: "related")
    }

    /// GET ``/api/mangas/:id/screenshots``
    func screenshots(id: String) async throws -> [SwikiImage] {
        try await request(.get, id: id, route: "screenshots")
    }

    /// GET ``/api/mangas/:id/franchise``
    func franchise(id: String) async throws -> SwikiFranchise {
        try await request(.get, id: id, route: "franchise")
    }

    /// GET ``/api/mangas/:id/external_links``
    func externalLinks(id: String) async throws -> [SwikiExternalLink] {
        try await request(.get, id: id, route: "external_links")
    }

    /// GET ``/api/mangas/:id/topics``
    func topics(id: String, query: SwikiV1MangasQuery = .init()) async throws -> [SwikiTopic] {
        try await request(.get, id: id, route: "topics", query: query.asSwikiQuery)
    }

}
