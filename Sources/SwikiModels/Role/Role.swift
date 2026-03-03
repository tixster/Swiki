import Foundation

public struct SwikiRole: Decodable, Sendable {
    public let roles: [String]
    public let rolesRu: [String]
    public let character: SwikiCharacter?
    public let person: SwikiCharacter?

    enum CodingKeys: String, CodingKey {
        case roles
        case rolesRu = "roles_russian"
        case character
        case person
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.roles = try container.decodeIfPresent([String].self, forKey: .roles) ?? []
        self.rolesRu = try container.decodeIfPresent([String].self, forKey: .rolesRu) ?? []
        self.character = try container.decodeIfPresent(SwikiCharacter.self, forKey: .character)
        self.person = try container.decodeIfPresent(SwikiCharacter.self, forKey: .person)
    }
}
