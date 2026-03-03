import Foundation
import SwikiModels

public struct SwikiV1RanobeClient: SwikiResourceSubclient {
    public typealias Model = SwikiManga
    public let resourceClient: SwikiResourceClient<SwikiManga>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "ranobe")
    }
}

public extension SwikiV1RanobeClient {
    func get(query: SwikiV1MangasQuery = .init()) async throws -> [SwikiManga] { try await list(query: query.asSwikiQuery) }
    func get(id: String, query: SwikiV1MangasQuery = .init()) async throws -> SwikiManga { try await resourceClient.get(id: id, query: query.asSwikiQuery) }
    func roles(id: String, query: SwikiV1MangasQuery = .init()) async throws -> [SwikiRole] {
        try await request(.get, id: id, action: "roles", query: query.asSwikiQuery)
    }
    func similar(id: String, query: SwikiV1MangasQuery = .init()) async throws -> [SwikiManga] {
        try await request(.get, id: id, action: "similar", query: query.asSwikiQuery)
    }
    func related(id: String, query: SwikiV1MangasQuery = .init()) async throws -> [SwikiRelated] {
        try await request(.get, id: id, action: "related", query: query.asSwikiQuery)
    }
    func screenshots(id: String, query: SwikiV1MangasQuery = .init()) async throws -> [SwikiImage] {
        try await request(.get, id: id, action: "screenshots", query: query.asSwikiQuery)
    }
    func franchise(id: String, query: SwikiV1MangasQuery = .init()) async throws -> SwikiFranchise {
        try await request(.get, id: id, action: "franchise", query: query.asSwikiQuery)
    }
    func externalLinks(id: String, query: SwikiV1MangasQuery = .init()) async throws -> [SwikiExternalLink] {
        try await request(.get, id: id, action: "external_links", query: query.asSwikiQuery)
    }
    func topics(id: String, query: SwikiV1MangasQuery = .init()) async throws -> [SwikiTopic] {
        try await request(.get, id: id, action: "topics", query: query.asSwikiQuery)
    }
}
