import Foundation
import SwikiModels

public struct SwikiV1MessagesClient: SwikiResourceSubclient {
    public typealias Model = SwikiMessage
    public let resourceClient: SwikiResourceClient<SwikiMessage>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "messages")
    }
}

public extension SwikiV1MessagesClient {

    /// GET ``/api/messages/:id``
    ///
    /// Show a message.
    func message(id: String) async throws -> SwikiMessage {
        try await resourceClient.get(id: id)
    }

    /// POST ``/api/messages``
    ///
    /// Create a message.
    ///
    /// - Note: Requires ``messages`` oauth scope
    func create(message: SwikiMessageCreatePayload) async throws -> SwikiMessage {
        try await resourceClient.create(body: SwikiMessageCreatePayloadBody(message: message))
    }

    /// PUT ``/api/messages/:id``
    ///
    /// Update a message.
    ///
    /// - Note: Requires ``messages`` oauth scope
    func update(id: String, message: SwikiMessageUpdatePayload) async throws -> SwikiMessage {
        try await resourceClient.update(
            id: id,
            body: SwikiMessageUpdatePayloadBody(message: message),
            method: .put
        )
    }

    /// DELETE ``/api/messages/:id``
    ///
    /// Delete a message.
    ///
    /// - Note: Requires ``messages`` oauth scope
    func delete(id: String) async throws {
        try await resourceClient.delete(id: id)
    }

    /// POST ``/api/messages/delete_all``
    ///
    /// Delete all messages.
    ///
    /// - Note: Requires ``messages`` oauth scope
    func deleteAll(payload: SwikiMessageDeleteAllPayload) async throws {
        try await request(.post, route: "delete_all", body: payload)
    }


    /// POST ``/api/messages/mark_read``
    ///
    /// Mark a message as read.
    ///
    /// - Note: Requires ``messages`` oauth scope
    func markRead(payload: SwikiMessageMarkReadPayload) async throws {
        try await request(.post, route: "mark_read", body: payload)
    }

    /// POST ``/api/messages/read_all``
    ///
    /// Alias endpoint to mark all messages as read.
    ///
    /// - Note: Requires ``messages`` oauth scope
    func readAll(payload: SwikiMessageReadAllPayload) async throws {
        try await request(.post, route: "read_all", body: payload)
    }

}
