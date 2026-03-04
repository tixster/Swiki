import Foundation

struct SwikiCommentUpdateBody: Encodable, Sendable {
    let comment: SwikiCommentUpdatePayload
}

public struct SwikiCommentUpdatePayload: Encodable, Sendable {
    public let body: String
    public init(body: String) {
        self.body = body
    }
}
