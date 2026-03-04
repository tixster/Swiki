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
    func get() async throws -> [SwikiStyle] { try await list() }
    func get(id: String) async throws -> SwikiStyle { try await resourceClient.get(id: id) }
    func preview<Body: Encodable>(body: Body) async throws -> SwikiStyle {
        try await request(.post, route: "preview", body: body)
    }
    func create<Body: Encodable>(body: Body) async throws -> SwikiStyle {
        try await resourceClient.create(body: body)
    }
    func update<Body: Encodable>(id: String, body: Body) async throws -> SwikiStyle {
        try await resourceClient.update(id: id, body: body, method: .post)
    }
}
