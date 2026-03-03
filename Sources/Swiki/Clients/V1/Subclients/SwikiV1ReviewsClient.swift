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
    func get(query: SwikiQuery = [:]) async throws -> [SwikiReview] { try await list(query: query) }
    func get(id: String, query: SwikiQuery = [:]) async throws -> SwikiReview { try await resourceClient.get(id: id, query: query) }
    func create<Body: Encodable>(body: Body, query: SwikiQuery = [:]) async throws -> SwikiReview {
        try await resourceClient.create(body: body, query: query)
    }
    func update<Body: Encodable>(id: String, body: Body, query: SwikiQuery = [:]) async throws -> SwikiReview {
        try await resourceClient.update(id: id, body: body, query: query, method: .put)
    }
    func delete(id: String, query: SwikiQuery = [:]) async throws { try await resourceClient.delete(id: id, query: query) }
}
