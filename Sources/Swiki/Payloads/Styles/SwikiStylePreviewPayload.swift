import Foundation

struct SwikiStylePreviewPayloadBody: Encodable, Sendable {
    let style: SwikiStylePreviewPayload
}

public struct SwikiStylePreviewPayload: Encodable, Sendable {
    public let css: String
    public init(css: String) {
        self.css = css
    }
}
