import Foundation
import SwikiModels

public struct SwikiV1UserImagesClient: SwikiResourceSubclient {
    public typealias Model = SwikiUserImage
    public let resourceClient: SwikiResourceClient<SwikiUserImage>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "user_images")
    }
}

public extension SwikiV1UserImagesClient {
    func create<Body: Encodable>(body: Body, query: SwikiQuery = [:]) async throws -> SwikiUserImage {
        try await resourceClient.create(body: body, query: query)
    }
    func delete(id: String, query: SwikiQuery = [:]) async throws { try await resourceClient.delete(id: id, query: query) }
}
