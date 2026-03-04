import Foundation

struct SwikiStyleCreatePayloadBody: Encodable, Sendable {
    let style: SwikiStyleCreatePayload
}

public struct SwikiStyleCreatePayload: Encodable, Sendable {
    public let css: String
    public let name: String
    public let ownerId: String
    public let ownerType: SwikiStyleOwnerType

    enum CodingKeys: String, CodingKey {
        case css
        case name
        case ownerId = "owner_id"
        case ownerType = "owner_type"
    }

    public init(
        css: String,
        name: String,
        ownerId: String,
        ownerType: SwikiStyleOwnerType
    ) {
        self.css = css
        self.name = name
        self.ownerId = ownerId
        self.ownerType = ownerType
    }

}
