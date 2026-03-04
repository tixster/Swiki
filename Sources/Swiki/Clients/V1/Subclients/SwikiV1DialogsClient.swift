import Foundation
import SwikiModels

/// GET ``/api/dialogs``
///
/// - Note:
/// Requires ``messages`` oauth scope
public struct SwikiV1DialogsClient: SwikiResourceSubclient {
    public typealias Model = SwikiDialog
    public let resourceClient: SwikiResourceClient<SwikiDialog>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "dialogs")
    }
}

public extension SwikiV1DialogsClient {

    /// GET ``/api/dialogs``
    ///
    /// List dialogs
    /// - Note:
    /// Requires ``messages`` oauth scope
    func list(query: SwikiQuery = [:]) async throws -> [SwikiDialog] {
        try await request(.get, query: query)
    }

    /// GET ``/api/dialogs/:id``
    ///
    /// Show a dialog
    /// - Note:
    /// Requires ``messages`` oauth scope
    func messages(targetUserId: String, query: SwikiQuery = [:]) async throws -> [SwikiMessage] {
        try await request(.get, id: targetUserId, query: query)
    }

    /// DELETE ``/api/dialogs/:id``
    ///
    /// Destroy a dialog
    /// - Note:
    /// Requires ``messages`` oauth scope
    func delete(targetUserId: String) async throws {
        try await request(.delete, id: targetUserId)
    }

}
