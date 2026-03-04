import Foundation

public struct SwikiClubPreviewLogo: Decodable, Sendable {
    public let original: URL
    public let main: URL
    public let x96: URL?
    public let x73: URL?
    public let x48: URL?
}

public struct SwikiClubPreview: Decodable, Sendable {
    public let id: String
    public let name: String
    public let logo: SwikiClubPreviewLogo
    public let isCensored: Bool?
    public let joinPolicy: SwikiClubJoinPolicy
    public let commentPolicy: SwikiClubCommentPolicy

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
        case isCensored = "is_censored"
        case joinPolicy = "join_policy"
        case commentPolicy = "comment_policy"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.logo = try container.decode(SwikiClubPreviewLogo.self, forKey: .logo)
        self.isCensored = try container.decodeIfPresent(Bool.self, forKey: .isCensored)
        self.joinPolicy = try container.decode(SwikiClubJoinPolicy.self, forKey: .joinPolicy)
        self.commentPolicy = try container.decode(SwikiClubCommentPolicy.self, forKey: .commentPolicy)
    }
}

public typealias SwikiClubPeview = SwikiClubPreview
