import Foundation

/**
 - warning: Поле ``hosting``
 может иметь значение только через API V1
 */
public struct SwikiVideo: Decodable, Sendable {
    public let id: Int
    public let url: URL
    public let imageUrl: URL
    public let playerUrl: URL
    public let name: String?
    public let kind: SwikiVideoKind
    /// - warning: может иметь значение только через API V1
    public let hosting: SwikiVideoHosting?

    enum CodingKeysRest: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case kind
        case name
        case playerUrl = "player_url"
        case url
        case hosting
    }

    enum CodingKeysGraphQl: String, CodingKey {
        case id
        case imageUrl
        case kind
        case name
        case playerUrl
        case url
    }

    public init(from decoder: any Decoder) throws {
        let apiType = try decoder.getApiType()
        if apiType == .rest {
            let container = try decoder.container(keyedBy: CodingKeysRest.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.url = try container.decode(URL.self, forKey: .url)
            self.imageUrl = try container.decode(URL.self, forKey: .imageUrl)
            self.playerUrl = try container.decode(URL.self, forKey: .playerUrl)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.kind = try container.decode(SwikiVideoKind.self, forKey: .kind)
            self.hosting = try container.decodeIfPresent(SwikiVideoHosting.self, forKey: .hosting)
        } else {
            let container = try decoder.container(keyedBy: CodingKeysGraphQl.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.url = try container.decode(URL.self, forKey: .url)
            self.imageUrl = try container.decode(URL.self, forKey: .imageUrl)
            self.playerUrl = try container.decode(URL.self, forKey: .playerUrl)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.kind = try container.decode(SwikiVideoKind.self, forKey: .kind)
            self.hosting = nil
        }
    }

}
