import Foundation
import SwikiModels

public struct SwikiV1AnimesClient: SwikiResourceSubclient {
    public typealias Model = SwikiAnimeV1
    public let resourceClient: SwikiResourceClient<SwikiAnimeV1>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "animes")
    }
}

public extension SwikiV1AnimesClient {
    func get(query: SwikiV1AnimesQuery = .init()) async throws -> [SwikiAnimeV1Preview] {
        try await request(.get, query: query.asSwikiQuery)
    }
    func get(id: String) async throws -> SwikiAnimeV1 { try await resourceClient.get(id: id) }
    func roles(id: String) async throws -> [SwikiRole] {
        try await request(.get, id: id, action: "roles")
    }
    func similar(id: String) async throws -> [SwikiAnimeV1Preview] {
        try await request(.get, id: id, action: "similar")
    }
    func related(id: String) async throws -> [SwikiRelated] {
        try await request(.get, id: id, action: "related")
    }
    func screenshots(id: String) async throws -> [SwikiImage] {
        try await request(.get, id: id, action: "screenshots")
    }
    func franchise(id: String) async throws -> SwikiFranchise {
        try await request(.get, id: id, action: "franchise")
    }
    func externalLinks(id: String) async throws -> [SwikiExternalLink] {
        try await request(.get, id: id, action: "external_links")
    }
    func topics(id: String, query: SwikiV1AnimesQuery = .init()) async throws -> [SwikiTopic] {
        try await request(.get, id: id, action: "topics", query: query.asSwikiQuery)
    }
}
