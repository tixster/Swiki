import Foundation
import SwikiModels

public struct SwikiV1RanobeClient: SwikiResourceSubclient {
    public typealias Model = SwikiMangaV1
    public let resourceClient: SwikiResourceClient<SwikiMangaV1>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "ranobe")
    }
}

public extension SwikiV1RanobeClient {
    func get(query: SwikiV1MangasQuery = .init()) async throws -> [SwikiMangaV1Preview] {
        try await request(.get, query: query.asSwikiQuery)
    }
    func get(id: String) async throws -> SwikiMangaV1 { try await resourceClient.get(id: id) }
    func roles(id: String) async throws -> [SwikiRole] {
        try await request(.get, id: id, route: "roles")
    }
    func similar(id: String) async throws -> [SwikiMangaV1Preview] {
        try await request(.get, id: id, route: "similar")
    }
    func related(id: String) async throws -> [SwikiRelated] {
        try await request(.get, id: id, route: "related")
    }
    func screenshots(id: String) async throws -> [SwikiImage] {
        try await request(.get, id: id, route: "screenshots")
    }
    func franchise(id: String) async throws -> SwikiFranchise {
        try await request(.get, id: id, route: "franchise")
    }
    func externalLinks(id: String) async throws -> [SwikiExternalLink] {
        try await request(.get, id: id, route: "external_links")
    }
    func topics(id: String, query: SwikiV1MangasQuery = .init()) async throws -> [SwikiTopic] {
        try await request(.get, id: id, route: "topics", query: query.asSwikiQuery)
    }
}
