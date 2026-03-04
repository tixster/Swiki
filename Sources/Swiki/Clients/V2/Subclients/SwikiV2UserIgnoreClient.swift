import Foundation
import SwikiModels

public struct SwikiV2UserIgnoreClient: SwikiResourceSubclient {
    public typealias Model = SwikiUserIgnore
    public let resourceClient: SwikiResourceClient<Model>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "users")
    }

}

public extension SwikiV2UserIgnoreClient {
    /// POST ``/api/v2/users/:user_id/ignore``
    ///
    /// Ignore a user.
    ///
    /// - Note: Requires `ignores` oauth scope
    @discardableResult
    func ignore(userId: String) async throws -> SwikiUserIgnore {
        try await request(.post, id: userId, route: "ignore")
    }

    /// DELETE ``/api/v2/users/:user_id/ignore``
    ///
    /// Unignore a user
    ///
    /// - Note: Requires `ignores` oauth scope
    @discardableResult
    func unignore(userId: String) async throws -> SwikiUserIgnore {
        try await request(.delete, id: userId, route: "ignore")
    }

}
