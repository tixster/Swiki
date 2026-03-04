import Foundation
import SwikiModels

public struct SwikiMessageDeleteAllPayload: Encodable, Sendable {
    public let type: SwikiMessageType

    public init(type: SwikiMessageType) {
        self.type = type
    }

}
