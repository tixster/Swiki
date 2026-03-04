import Foundation
import SwikiModels

public struct SwikiV1ReviewsClient: SwikiResourceSubclient {
    public typealias Model = SwikiReview
    public let resourceClient: SwikiResourceClient<SwikiReview>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "reviews")
    }
}

public extension SwikiV1ReviewsClient {

    /// POST ``/api/reviews``
    ///
    /// Create a review.
    func create(review: SwikiReviewCreatePayload) async throws -> SwikiReview {
        try await resourceClient.create(body: SwikiReviewCreatePayloadBody(review: review))
    }

    /// PUT ``/api/reviews/:id``
    ///
    /// Update a review.
    func update(id: String, review: SwikiReviewUpdatePayload) async throws -> SwikiReview {
        try await resourceClient.update(id: id, body: SwikiReviewUpdatePayloadBody(review: review), method: .put)
    }

    /// DELETE ``/api/reviews/:id``
    ///
    /// Delete a review.
    func delete(id: String) async throws {
        try await resourceClient.delete(id: id)
    }

}
