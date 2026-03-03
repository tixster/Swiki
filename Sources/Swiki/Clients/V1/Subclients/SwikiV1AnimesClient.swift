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
    func index(query: SwikiQuery = [:]) async throws -> [SwikiAnimeV1Preview] {
        try await request(.get, query: query)
    }
    func get(id: String, query: SwikiQuery = [:]) async throws -> SwikiAnimeV1 { try await resourceClient.get(id: id, query: query) }
    func roles(id: String, query: SwikiQuery = [:]) async throws -> [SwikiRole] {
        try await request(.get, id: id, action: "roles", query: query)
    }
    func similar(id: String, query: SwikiQuery = [:]) async throws -> [SwikiAnimeV1Preview] {
        try await request(.get, id: id, action: "similar", query: query)
    }
    func related(id: String, query: SwikiQuery = [:]) async throws -> [SwikiRelated] {
        try await request(.get, id: id, action: "related", query: query)
    }
    func screenshots(id: String, query: SwikiQuery = [:]) async throws -> [SwikiImage] {
        try await request(.get, id: id, action: "screenshots", query: query)
    }
    func franchise(id: String, query: SwikiQuery = [:]) async throws -> SwikiFranchise {
        try await request(.get, id: id, action: "franchise", query: query)
    }
    func externalLinks(id: String, query: SwikiQuery = [:]) async throws -> [SwikiExternalLink] {
        try await request(.get, id: id, action: "external_links", query: query)
    }
    func topics(id: String, query: SwikiQuery = [:]) async throws -> [SwikiTopic] {
        try await request(.get, id: id, action: "topics", query: query)
    }
}
