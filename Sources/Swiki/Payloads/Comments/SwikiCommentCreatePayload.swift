import Foundation
import SwikiModels

struct SwikiCommentCreateBody: Encodable, Sendable {
    let broadcast: Bool?
    let comment: SwikiCommentCreatePayload
}

public struct SwikiCommentCreatePayload: Encodable, Sendable {
    public let body: String
    public let commentableId: String
    /// When set to Anime, Manga, Character, Person, Article, Club, ClubPage, Collection, Critique, Review
    /// comment is attached to commentable main topic
    public let commentableType: SwikiCommentableType
    public let isOfftopic: Bool?

    enum CodingKeys: String, CodingKey {
        case body
        case commentableId = "commentable_id"
        case commentableType = "commentable_type"
        case isOfftopic = "is_offtopic"
    }
    
    ///
    /// - Parameters:
    ///   - body: body
    ///   - commentableId: commentableId
    ///   - commentableType: When set to Anime, Manga, Character, Person, Article, Club, ClubPage, Collection, Critique, Review comment is attached to commentable main topic
    ///   - isOfftopic: isOfftopic
    public init(
        body: String,
        commentableId: String,
        commentableType: SwikiCommentableType,
        isOfftopic: Bool?
    ) {
        self.body = body
        self.commentableId = commentableId
        self.commentableType = commentableType
        self.isOfftopic = isOfftopic
    }

}
