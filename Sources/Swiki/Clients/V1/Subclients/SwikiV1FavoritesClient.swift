import Foundation
import SwikiModels

/// ``/api/favorites``
public struct SwikiV1FavoritesClient: Sendable {

    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1FavoritesClient {

    /// POST ``/api/favorites/:linked_type/:linked_id(/:kind)``
    ///
    /// Create a favorite
    @discardableResult
    func create(
        linkedType: SwikiFavoritesLinkedTypeCreate,
        linkedId: String
    ) async throws -> SwikiNoticeResponse {
        let route = [linkedId, linkedType.kindRawValue].compactMap { value in
            guard let value, !value.isEmpty else { return nil }
            return value
        }.joined(separator: "/")
        return try await transport.request(
            version: .v1,
            method: .post,
            path: "favorites",
            id: linkedType.rawValue,
            route: route
        )
    }

    /// DELETE ``/api/favorites/:linked_type/:linked_id``
    ///
    /// Destroy a favorite
    @discardableResult
    func delete(
        linkedType: SwikiFavoriteLinkedType,
        linkedId: String
    ) async throws -> SwikiNoticeResponse {
        try await transport.request(
            version: .v1,
            method: .delete,
            path: "favorites",
            id: linkedType.rawValue,
            route: linkedId
        )
    }

    /// POST ``/api/favorites/:id/reorder``
    ///
    /// Assign a new position to a favorite
    func reorder(id: String, newIndex: Int?) async throws {
        struct Payload: Encodable {
            let new_index: String?
        }
        return try await transport.request(
            version: .v1,
            method: .post,
            path: "favorites",
            id: id,
            route: "reorder",
            body: Payload(new_index: newIndex?.description)
        )
    }
}
