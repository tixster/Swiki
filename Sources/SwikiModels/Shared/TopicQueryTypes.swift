import Foundation

public enum SwikiTopicForum: String, Sendable, Codable {
    case all
    case animanga
    case site
    case games
    case vn
    case contests
    case offtopic
    case clubs
    case myClubs = "my_clubs"
    case critiques
    case news
    case collections
    case articles
    case cosplay
}

public enum SwikiTopicLinkedType: String, Sendable, Codable {
    case anime = "Anime"
    case manga = "Manga"
    case ranobe = "Ranobe"
    case character = "Character"
    case person = "Person"
    case club = "Club"
    case clubPage = "ClubPage"
    case critique = "Critique"
    case review = "Review"
    case contest = "Contest"
    case cosplayGallery = "CosplayGallery"
    case collection = "Collection"
    case article = "Article"
}

public enum SwikiTopicType: String, Sendable, Codable {
    case topic = "Topic"
    case clubUserTopic = "Topics::ClubUserTopic"
    case entryTopic = "Topics::EntryTopic"
    case entryAnimeTopic = "Topics::EntryTopics::AnimeTopic"
    case entryArticleTopic = "Topics::EntryTopics::ArticleTopic"
    case entryCharacterTopic = "Topics::EntryTopics::CharacterTopic"
    case entryClubPageTopic = "Topics::EntryTopics::ClubPageTopic"
    case entryClubTopic = "Topics::EntryTopics::ClubTopic"
    case entryCollectionTopic = "Topics::EntryTopics::CollectionTopic"
    case entryContestTopic = "Topics::EntryTopics::ContestTopic"
    case entryCosplayGalleryTopic = "Topics::EntryTopics::CosplayGalleryTopic"
    case entryMangaTopic = "Topics::EntryTopics::MangaTopic"
    case entryPersonTopic = "Topics::EntryTopics::PersonTopic"
    case entryRanobeTopic = "Topics::EntryTopics::RanobeTopic"
    case entryCritiqueTopic = "Topics::EntryTopics::CritiqueTopic"
    case entryReviewTopic = "Topics::EntryTopics::ReviewTopic"
    case newsTopic = "Topics::NewsTopic"
    case newsContestStatusTopic = "Topics::NewsTopics::ContestStatusTopic"
}
