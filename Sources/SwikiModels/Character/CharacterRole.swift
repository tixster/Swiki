import Foundation

public struct SwikiCharacterRole: Decodable, Sendable {
    public let id: String
    public let character: SwikiCharacter
    public let rolesEn: [String]
    public let rolesRu: [String]
}
