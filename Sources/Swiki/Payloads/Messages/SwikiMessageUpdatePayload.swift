import Foundation

struct SwikiMessageUpdatePayloadBody: Encodable, Sendable {
    let message: SwikiMessageUpdatePayload
}


public struct SwikiMessageUpdatePayload: Encodable, Sendable {
    public let body: String

    public init(body: String) {
        self.body = body
    }

}
