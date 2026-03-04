import Foundation

public enum SwikiCommentableType: String, Codable, Sendable {
    case topic = "Topic"
    case user = "User"
    case anime = "Anime"
    case manga = "Manga"
    case character = "Character"
    case person = "Person"
    case article = "Article"
    case club = "Club"
    case clubPage = "ClubPage"
    case collection = "Collection"
    case critique = "Critique"
    case review = "Review"
}
