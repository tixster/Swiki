import Foundation
import SwikiModels

public struct SwikiMessageReadAllPayload: Encodable, Sendable {
    public let type: SwikiMessageType

    public init(type: SwikiMessageType) {
        self.type = type
    }
}
