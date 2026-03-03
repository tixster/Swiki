import Foundation
import SwikiModels

public struct SwikiV1Client: Sendable {
    private let transport: SwikiHTTPTransport
    public let achievements: SwikiV1AchievementsClient
    public let animes: SwikiV1AnimesClient
    public let appears: SwikiV1AppearsClient
    public let bans: SwikiV1BansClient
    public let calendars: SwikiV1CalendarsClient
    public let characters: SwikiV1CharactersClient
    public let clubs: SwikiV1ClubsClient
    public let collections: SwikiV1CollectionsClient
    public let comments: SwikiV1CommentsClient
    public let constants: SwikiV1ConstantsClient
    public let dialogs: SwikiV1DialogsClient
    public let favorites: SwikiV1FavoritesClient
    public let forums: SwikiV1ForumsClient
    public let friends: SwikiV1FriendsClient
    public let genres: SwikiV1GenresClient
    public let ignores: SwikiV1IgnoresClient
    public let mangas: SwikiV1MangasClient
    public let messages: SwikiV1MessagesClient
    public let people: SwikiV1PeopleClient
    public let publishers: SwikiV1PublishersClient
    public let ranobe: SwikiV1RanobeClient
    public let reviews: SwikiV1ReviewsClient
    public let stats: SwikiV1StatsClient
    public let studios: SwikiV1StudiosClient
    public let styles: SwikiV1StylesClient
    public let topicIgnores: SwikiV1TopicIgnoresClient
    public let topics: SwikiV1TopicsClient
    public let userImages: SwikiV1UserImagesClient
    public let userRates: SwikiV1UserRatesClient
    public let userRatesLogs: SwikiV1UserRatesLogsClient
    public let users: SwikiV1UsersClient
    public let videos: SwikiV1VideosClient
    public let whoami: SwikiV1WhoamiClient

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
        self.achievements = SwikiV1AchievementsClient(transport: transport)
        self.animes = SwikiV1AnimesClient(transport: transport)
        self.appears = SwikiV1AppearsClient(transport: transport)
        self.bans = SwikiV1BansClient(transport: transport)
        self.calendars = SwikiV1CalendarsClient(transport: transport)
        self.characters = SwikiV1CharactersClient(transport: transport)
        self.clubs = SwikiV1ClubsClient(transport: transport)
        self.collections = SwikiV1CollectionsClient(transport: transport)
        self.comments = SwikiV1CommentsClient(transport: transport)
        self.constants = SwikiV1ConstantsClient(transport: transport)
        self.dialogs = SwikiV1DialogsClient(transport: transport)
        self.favorites = SwikiV1FavoritesClient(transport: transport)
        self.forums = SwikiV1ForumsClient(transport: transport)
        self.friends = SwikiV1FriendsClient(transport: transport)
        self.genres = SwikiV1GenresClient(transport: transport)
        self.ignores = SwikiV1IgnoresClient(transport: transport)
        self.mangas = SwikiV1MangasClient(transport: transport)
        self.messages = SwikiV1MessagesClient(transport: transport)
        self.people = SwikiV1PeopleClient(transport: transport)
        self.publishers = SwikiV1PublishersClient(transport: transport)
        self.ranobe = SwikiV1RanobeClient(transport: transport)
        self.reviews = SwikiV1ReviewsClient(transport: transport)
        self.stats = SwikiV1StatsClient(transport: transport)
        self.studios = SwikiV1StudiosClient(transport: transport)
        self.styles = SwikiV1StylesClient(transport: transport)
        self.topicIgnores = SwikiV1TopicIgnoresClient(transport: transport)
        self.topics = SwikiV1TopicsClient(transport: transport)
        self.userImages = SwikiV1UserImagesClient(transport: transport)
        self.userRates = SwikiV1UserRatesClient(transport: transport)
        self.userRatesLogs = SwikiV1UserRatesLogsClient(transport: transport)
        self.users = SwikiV1UsersClient(transport: transport)
        self.videos = SwikiV1VideosClient(transport: transport)
        self.whoami = SwikiV1WhoamiClient(transport: transport)
    }
}
