import Foundation
import SwikiModels

public struct SwikiV2EpisodeNotificationsClient: SwikiResourceSubclient {
    public typealias Model = SwikiEpisodeNotification
    public let resourceClient: SwikiResourceClient<SwikiEpisodeNotification>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "episode_notifications")
    }
}

public extension SwikiV2EpisodeNotificationsClient {
    func index(query: SwikiQuery = [:]) async throws -> [SwikiEpisodeNotification] {
        try await list(query: query)
    }

    func get(id: String, query: SwikiQuery = [:]) async throws -> SwikiEpisodeNotification {
        try await resourceClient.get(id: id, query: query)
    }

    func create<Body: Encodable>(body: Body, query: SwikiQuery = [:]) async throws -> SwikiEpisodeNotification {
        try await resourceClient.create(body: body, query: query)
    }

    func update<Body: Encodable>(
        id: String,
        body: Body,
        query: SwikiQuery = [:],
        method: SwikiHTTPMethod = .put
    ) async throws -> SwikiEpisodeNotification {
        try await resourceClient.update(id: id, body: body, query: query, method: method)
    }

    func delete(id: String, query: SwikiQuery = [:]) async throws {
        try await resourceClient.delete(id: id, query: query)
    }
}
