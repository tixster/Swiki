import Foundation
import SwikiModels

public struct SwikiV1UserImagesClient: Sendable {
    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1UserImagesClient {

    /// POST ``/api/user_images``
    ///
    /// Upload a user image.
    ///
    /// - Note: Requires ``comments`` oauth scope
    func create(
        image: SwikiUserImagePayload
    ) async throws -> SwikiUserImageUploadResponse {
        let mp = try image.multipart()
        return try await transport
            .request(
                version: .v1,
                method: .post,
                path: "user_images",
                contentType: mp.contentType,
                body: mp.body
            )
    }

}

