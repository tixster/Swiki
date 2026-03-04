import Foundation

public struct SwikiContestMatch: Decodable, Sendable {
    public let id: String
    public let state: SwikiContestMatchState
    public let winnerId: Int
    public let leftAnime: SwikiAnimeV1Preview?
    public let leftCharacter: SwikiCharacterPreview?
    public let leftId: Int?
    public let leftVotes: Int?
    public let rightAnime: SwikiAnimeV1Preview?
    public let rightCharacter: SwikiCharacterPreview?
    public let rightId: Int?
    public let rightVotes: Int?
}
