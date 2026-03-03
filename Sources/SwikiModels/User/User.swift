import Foundation

public struct SwikiUser: Decodable, Sendable {
    public let id: String
    public let nickname: String
    public let url: URL?
    public let avatar: URL
    public let image: SwikiPureImage?
    public let lastOnlineAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case url
        case avatar
        case image
        case lastOnlineAt = "last_online_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.avatar = try container.decode(URL.self, forKey: .avatar)
        self.image = try container.decodeIfPresent(SwikiPureImage.self, forKey: .image)
        self.lastOnlineAt = try container.decode(Date.self, forKey: .lastOnlineAt)
    }
}

public struct SwikiPureImage: Decodable, Sendable {
    public let x160: URL?
    public let x148: URL?
    public let x80: URL?
    public let x64: URL?
    public let x48: URL?
    public let x32: URL?
    public let x16: URL?
}

public struct SwikiUserInfo: Decodable, Sendable {
    public let id: String
    public let nickname: String
    public let avatar: URL
    public let image: SwikiPureImage?
    public let lastOnlineAt: Date
    public let name: String?
    public let sex: String?
    public let website: String?
    public let locale: String?
    public let birthOn: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case avatar
        case image
        case lastOnlineAt = "last_online_at"
        case name
        case sex
        case website
        case locale
        case birthOn = "birth_on"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.avatar = try container.decode(URL.self, forKey: .avatar)
        self.image = try container.decodeIfPresent(SwikiPureImage.self, forKey: .image)
        self.lastOnlineAt = try container.decode(Date.self, forKey: .lastOnlineAt)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.sex = try container.decodeIfPresent(String.self, forKey: .sex)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.birthOn = try container.decodeIfPresent(Date.self, forKey: .birthOn)
    }
}

public struct SwikiUserId: Decodable, Sendable {
    public let id: String
    public let nickname: String
    public let avatar: URL
    public let image: SwikiPureImage?
    public let lastOnlineAt: Date
    public let name: String?
    public let sex: String?
    public let website: String?
    public let locale: String?
    public let fullYears: Int?
    public let lastOnline: String?
    public let location: String?
    public let banned: Bool
    public let about: String?
    public let aboutHtml: String?
    public let commonInfo: [String]
    public let showComments: Bool?
    public let inFriends: Bool?
    public let isIgnored: Bool?
    public let stats: SwikiStats?
    public let styleId: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case avatar
        case image
        case lastOnlineAt = "last_online_at"
        case name
        case sex
        case website
        case locale
        case fullYears = "full_years"
        case lastOnline = "last_online"
        case location
        case banned
        case about
        case aboutHtml = "about_html"
        case commonInfo = "common_info"
        case showComments = "show_comments"
        case inFriends = "in_friends"
        case isIgnored = "is_ignored"
        case stats
        case styleId = "style_id"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.avatar = try container.decode(URL.self, forKey: .avatar)
        self.image = try container.decodeIfPresent(SwikiPureImage.self, forKey: .image)
        self.lastOnlineAt = try container.decode(Date.self, forKey: .lastOnlineAt)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.sex = try container.decodeIfPresent(String.self, forKey: .sex)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
        self.locale = try container.decodeIfPresent(String.self, forKey: .locale)
        self.fullYears = try container.decodeIfPresent(Int.self, forKey: .fullYears)
        self.lastOnline = try container.decodeIfPresent(String.self, forKey: .lastOnline)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.banned = try container.decodeIfPresent(Bool.self, forKey: .banned) ?? false
        self.about = try container.decodeIfPresent(String.self, forKey: .about)
        self.aboutHtml = try container.decodeIfPresent(String.self, forKey: .aboutHtml)
        self.commonInfo = try container.decodeIfPresent([String].self, forKey: .commonInfo) ?? []
        self.showComments = try container.decodeIfPresent(Bool.self, forKey: .showComments)
        self.inFriends = try container.decodeIfPresent(Bool.self, forKey: .inFriends)
        self.isIgnored = try container.decodeIfPresent(Bool.self, forKey: .isIgnored)
        self.stats = try container.decodeIfPresent(SwikiStats.self, forKey: .stats)
        self.styleId = try container.decodeStringOrIntIfPresent(forKey: .styleId)
    }
}
