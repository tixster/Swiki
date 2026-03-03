import Foundation
import SwikiModels

public struct SwikiV1UserImagesClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1UserImagesClient {
    func create<Body: Encodable>(
        body: Body,
        query: some SwikiQueryConvertible = [:] as SwikiQuery
    ) async throws -> SwikiUserImageUploadResponse {
        try await transport.request(version: .v1, method: .post, path: "user_images", query: query, body: body)
    }
}
