import Foundation
import SwikiModels

public struct SwikiV1StylesClient: SwikiResourceSubclient {
    public typealias Model = SwikiStyle
    public let resourceClient: SwikiResourceClient<SwikiStyle>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "styles")
    }
}

public extension SwikiV1StylesClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiStyle] { try await list(query: query) }
    func get(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiStyle { try await resourceClient.get(id: id, query: query) }
    func preview<Body: Encodable>(body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiStyle {
        try await request(.post, action: "preview", query: query, body: body)
    }
    func create<Body: Encodable>(body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiStyle {
        try await resourceClient.create(body: body, query: query)
    }
    func update<Body: Encodable>(id: String, body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiStyle {
        try await resourceClient.update(id: id, body: body, query: query, method: .post)
    }
}
