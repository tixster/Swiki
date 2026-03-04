import Foundation
import SwikiModels

public struct SwikiV1VideosClient: SwikiResourceSubclient {
    public typealias Model = SwikiVideo
    public let resourceClient: SwikiResourceClient<SwikiVideo>
    let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "animes")
    }
}

public extension SwikiV1VideosClient {


    /// GET ``/api/animes/:anime_id/videos``
    ///
    ///      List videos
    func list(animeId: String) async throws -> [SwikiVideo] {
        try await request(.get, id: animeId, route: "videos")
    }

    /// POST ``/api/animes/:anime_id/videos``
    ///
    /// Create a video for an anime.
    func create(
        animeId: String,
        video: SwikiVideosCreatePayload
    ) async throws -> SwikiVideo {
        try await request(
            .get,
            id: animeId,
            route: "videos",
            body: SwikiVideosCreatePayloadBody(video: video)
        )
    }
    /// DELETE ``/api/animes/:anime_id/videos/:video_id``
    ///
    /// Delete a video from an anime.
    func delete(animeId: String, videoId: String) async throws {
        try await request(.delete, id: animeId, route: "videos/\(videoId)")
    }
    
}
