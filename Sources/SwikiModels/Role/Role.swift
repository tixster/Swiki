import Foundation

public struct SwikiRole: Decodable, Sendable {
    public let rolesRu: [String]
    public let rolesEn: [String]
    public let character: SwikiCharacter?
    public let person: SwikiPerson?

    enum CodingKeys: String, CodingKey {
        case rolesRu = "roles_russian"
        case rolesEn = "roles_english"
        case character
        case person
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rolesRu = try container.decodeIfPresent([String].self, forKey: .rolesRu) ?? []
        self.rolesEn = try container.decodeIfPresent([String].self, forKey: .rolesEn) ?? []
        self.character = try container.decodeIfPresent(SwikiCharacter.self, forKey: .character)
        self.person = try container.decodeIfPresent(SwikiPerson.self, forKey: .person)
    }
}
