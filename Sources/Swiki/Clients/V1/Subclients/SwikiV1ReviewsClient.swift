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
    func get() async throws -> [SwikiReview] { try await list() }
    func get(id: String) async throws -> SwikiReview { try await resourceClient.get(id: id) }
    func create<Body: Encodable>(body: Body, query: SwikiQuery = [:]) async throws -> SwikiReview {
        try await resourceClient.create(body: body, query: query)
    }
    func update<Body: Encodable>(id: String, body: Body, query: SwikiQuery = [:]) async throws -> SwikiReview {
        try await resourceClient.update(id: id, body: body, query: query, method: .put)
    }
    func delete(id: String) async throws { try await resourceClient.delete(id: id) }
}
