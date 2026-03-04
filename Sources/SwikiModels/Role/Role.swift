import Foundation

public struct SwikiRole: Decodable, Sendable {
    public let roles: [String]
    public let rolesRu: [String]
    public let character: SwikiCharacterPreview?
    public let person: SwikiPersonPreview?

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
        self.character = try container.decodeIfPresent(SwikiCharacterPreview.self, forKey: .character)
        self.person = try container.decodeIfPresent(SwikiPersonPreview.self, forKey: .person)
    }
}
