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

    /// GET ``/api/styles/:id``
    ///
    /// Show a style.
    func style(id: String) async throws -> SwikiStyle {
        try await resourceClient.get(id: id)
    }

    /// POST ``/api/styles/preview``
    ///
    /// Preview a style payload.
    func preview(style: SwikiStylePreviewPayload) async throws -> SwikiStyle {
        try await request(.post, route: "preview", body: SwikiStylePreviewPayloadBody(style: style))
    }

    /// POST ``/api/styles``
    ///
    /// Create a style.
    func create(style: SwikiStyleCreatePayload) async throws -> SwikiStyle {
        try await resourceClient.create(body: SwikiStyleCreatePayloadBody(style: style))
    }

    /// PUT ``/api/styles/:id``
    ///
    /// Update a style.
    func update(id: String, style: SwikiStyleUpdatePayload) async throws -> SwikiStyle {
        try await resourceClient.update(id: id, body: SwikiStyleUpdatePayloadBody(style: style), method: .put)
    }

}
