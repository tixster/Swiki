import Foundation
import SwikiModels

/// ``/api/comments``
public struct SwikiV1CommentsClient: SwikiResourceSubclient {
    public typealias Model = SwikiComment
    public let resourceClient: SwikiResourceClient<SwikiComment>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "comments")
    }
}

public extension SwikiV1CommentsClient {

    /// GET /api/comments
    ///
    /// List comments
    func list(query: SwikiV1CommentsQuery = .init()) async throws -> [SwikiComment] {
        try await request(.get, query: query.asSwikiQuery)
    }

    /// GET /api/comments/:id
    ///
    /// Show a comment
    func comment(id: String) async throws -> SwikiComment {
        try await resourceClient.get(id: id)
    }

    /// POST /api/comments
    /// 
    /// Create a comment
    /// 
    /// - Parameters:
    ///   - comment: comment model
    ///   - broadcast: Used to broadcast comment in club’s topic. Only club admins can broadcast.
    ///  - Note: Requires ``comments`` oauth scope
    @discardableResult
    func create(
        comment: SwikiCommentCreatePayload,
        broadcast: Bool? = nil,
    ) async throws -> SwikiComment {
        let body = SwikiCommentCreateBody(broadcast: broadcast, comment: comment)
        return try await resourceClient.create(body: body)
    }

    /// PUT ``/api/comments/:id``
    ///
    /// Update a comment
    ///
    /// - Note: Requires ``comments`` oauth scope.
    /// Use ``SwikiV2AbuseRequestsClient/offtopic(commentId:)`` to change ``is_offtopic`` field.
    @discardableResult
    func update(
        id: String,
        comment: SwikiCommentUpdatePayload
    ) async throws -> SwikiComment {
        try await resourceClient
            .update(
                id: id,
                body: SwikiCommentUpdateBody(comment: comment),
                method: .put
            )
    }

    /// DELETE ``/api/comments/:id``
    ///
    /// Destroy a comment
    func delete(id: String) async throws {
        try await resourceClient.delete(id: id)
    }

}
