import Foundation
import SwikiModels

public struct SwikiV1VideosClient: SwikiResourceSubclient {
    public typealias Model = SwikiVideo
    public let resourceClient: SwikiResourceClient<SwikiVideo>
    let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "videos")
    }
}

public extension SwikiV1VideosClient {
    func get(query: SwikiQuery = [:]) async throws -> [SwikiVideo] { try await list(query: query) }
    func get(animeId: String) async throws -> [SwikiVideo] {
        try await transport.request(version: .v1, method: .get, path: "animes/\(animeId)/videos")
    }
    func create<Body: Encodable>(
        animeId: String,
        body: Body
    ) async throws -> SwikiVideo {
        try await transport.request(
            version: .v1,
            method: .post,
            path: "animes/\(animeId)/videos",
            body: body
        )
    }
    func delete(animeId: String, videoId: String) async throws {
        try await transport.request(
            version: .v1,
            method: .delete,
            path: "animes/\(animeId)/videos",
            id: videoId
        )
    }
}
