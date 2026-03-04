import Foundation

struct SwikiStyleUpdatePayloadBody: Encodable, Sendable {
    let style: SwikiStyleUpdatePayload
}

public struct SwikiStyleUpdatePayload: Encodable, Sendable {
    public let css: String?
    public let name: String?

    public init(css: String?, name: String?) {
        self.css = css
        self.name = name
    }

}
