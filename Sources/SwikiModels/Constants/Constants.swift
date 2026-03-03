import Foundation

public struct SwikiAnimeConstants: Decodable, Sendable {
    public let kind: [String]
    public let status: [String]
    public let rating: [String]
    public let duration: [String]
}

public struct SwikiMangaConstants: Decodable, Sendable {
    public let kind: [String]
    public let status: [String]
}

public struct SwikiUserRateConstants: Decodable, Sendable {
    public let status: [String]
}

public struct SwikiClubConstants: Decodable, Sendable {
    public let joinPolicy: [String]
    public let commentPolicy: [String]
    public let imageUploadPolicy: [String]

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
