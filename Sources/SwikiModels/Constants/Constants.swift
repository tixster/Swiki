import Foundation

public struct SwikiAnimeConstants: Decodable, Sendable {
    public let kind: [SwikiAnimeKind]
    public let status: [SwikiAnimeStatus]
}

public struct SwikiMangaConstants: Decodable, Sendable {
    public let kind: [SwikiMangaKind]
    public let status: [SwikiMangaStatus]
}

public struct SwikiUserRateConstants: Decodable, Sendable {
    public let status: [SwikiUserRateStatus]
}

public struct SwikiClubConstants: Decodable, Sendable {
    public let joinPolicy: [SwikiClubJoinPolicy]
    public let commentPolicy: [SwikiClubCommentPolicy]
    public let imageUploadPolicy: [SwikiClubImageUploadPolicy]

    enum CodingKeys: String, CodingKey {
        case joinPolicy = "join_policy"
        case commentPolicy = "comment_policy"
        case imageUploadPolicy = "image_upload_policy"
    }
}

public struct SwikiSmileyConstant: Decodable, Sendable {
    public let bbcode: String
    public let path: String
}
