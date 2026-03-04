import Foundation

public struct SwikiPersonRole: Decodable, Sendable {
    public let id: String
    public let person: SwikiPersonPreview
    public let rolesEn: [String]
    public let rolesRu: [String]
}
