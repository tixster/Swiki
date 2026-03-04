import Foundation
import SwikiModels

struct SwikiClubUpdateBody: Encodable {
    let club: SwikiClubUpdatePayload
}

public struct SwikiClubUpdatePayload: Sendable, Encodable {
    public let name: String?
    public let description: String?
    public let displayImages: Bool?
    public let commentPolicy: SwikiClubCommentPolicy?
    public let topicPolicy: SwikiClubTopicPolicy?
    public let imageUploadPolicy: SwikiClubImageUploadPolicy?
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case displayImages = "display_images"
        case commentPolicy = "comment_policy"
        case topicPolicy = "topic_policy"
        case imageUploadPolicy = "image_upload_policy"
    }

    public init(
        name: String?,
        description: String?,
        displayImages: Bool?,
        commentPolicy: SwikiClubCommentPolicy?,
        topicPolicy: SwikiClubTopicPolicy?,
        imageUploadPolicy: SwikiClubImageUploadPolicy?
    ) {
        self.name = Self.ifNotNil(name)
        self.description = description
        self.displayImages = displayImages
        self.commentPolicy = commentPolicy
        self.topicPolicy = topicPolicy
        self.imageUploadPolicy = imageUploadPolicy
    }

    private static func ifNotNil(_ value: String?) -> String? {
        if let value, !value.isEmpty {
            return value
        }
        return nil
    }

}
