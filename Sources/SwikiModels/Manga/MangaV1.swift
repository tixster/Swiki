import Foundation

/// RestV1 full model for `/api/mangas/:id` and `/api/ranobe/:id`.
public struct SwikiMangaV1: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage
    public let url: URL
    public let kind: SwikiMangaKind
    public let score: String
    public let status: SwikiMangaStatus
    public let volumes: Int
    public let chapters: Int
    public let airedOn: Date?
    public let releasedOn: Date?
    public let english: [String]
    public let japanese: [String]
    public let synonims: [String]
    public let licenseNameRu: String?
    public let description: String?
    public let descriptionHtml: String?
    public let descriptionSource: String?
    public let franchise: String?
    public let favoured: Bool
    public let anons: Bool
    public let ongoing: Bool
    public let threadId: Int?
    public let topicId: Int?
    public let myAnimeListId: Int?
    public let ratesScoresStats: [SwikiRateScore]
    public let ratesStatusesStats: [SwikiRateStatus]
    public let updatedAt: Date?
    public let licensors: [String]
    public let genres: [SwikiGenre]
    public let publishers: [SwikiPublisher]
    public let userRate: SwikiUserRate?

    enum CodingKeysRest: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
        case kind
        case score
        case status
        case volumes
        case chapters
        case airedOn = "aired_on"
        case releasedOn = "released_on"
        case english
        case japanese
        case synonims
        case synonyms
        case licenseNameRu = "license_name_ru"
        case description
        case descriptionHtml = "description_html"
        case descriptionSource = "description_source"
        case franchise
        case favoured
        case anons
        case ongoing
        case threadId = "thread_id"
        case topicId = "topic_id"
        case myAnimeListId = "myanimelist_id"
        case ratesScoresStats = "rates_scores_stats"
        case ratesStatusesStats = "rates_statuses_stats"
        case updatedAt = "updated_at"
        case licensors
        case genres
        case publishers
        case userRate = "user_rate"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeysRest.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decode(SwikiImage.self, forKey: .image)
        self.url = try container.decode(URL.self, forKey: .url)
        self.kind = try container.decode(SwikiMangaKind.self, forKey: .kind)
        self.score = try container.decode(String.self, forKey: .score)
        self.status = try container.decode(SwikiMangaStatus.self, forKey: .status)
        self.volumes = try container.decodeIfPresent(Int.self, forKey: .volumes) ?? 0
        self.chapters = try container.decodeIfPresent(Int.self, forKey: .chapters) ?? 0
        self.airedOn = if let airedOnStr = try container.decodeIfPresent(String.self, forKey: .airedOn) {
            DateFormatter.yyyyMMdd.date(from: airedOnStr)
        } else { nil }
        self.releasedOn = if let releasedOnStr = try container.decodeIfPresent(String.self, forKey: .releasedOn) {
            DateFormatter.yyyyMMdd.date(from: releasedOnStr)
        } else { nil }
        self.english = try container.decodeIfPresent([String].self, forKey: .english) ?? []
        self.japanese = try container.decodeIfPresent([String].self, forKey: .japanese) ?? []
        self.synonims = (try? container.decode([String].self, forKey: .synonyms))
            ?? (try? container.decode([String].self, forKey: .synonims))
            ?? []
        self.licenseNameRu = try container.decodeIfPresent(String.self, forKey: .licenseNameRu)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.descriptionHtml = try container.decodeIfPresent(String.self, forKey: .descriptionHtml)
        self.descriptionSource = try container.decodeIfPresent(String.self, forKey: .descriptionSource)
        self.franchise = try container.decodeIfPresent(String.self, forKey: .franchise)
        self.favoured = try container.decodeIfPresent(Bool.self, forKey: .favoured) ?? false
        self.anons = try container.decodeIfPresent(Bool.self, forKey: .anons) ?? false
        self.ongoing = try container.decodeIfPresent(Bool.self, forKey: .ongoing) ?? false
        self.threadId = try container.decodeIfPresent(Int.self, forKey: .threadId)
        self.topicId = try container.decodeIfPresent(Int.self, forKey: .topicId)
        self.myAnimeListId = try container.decodeIfPresent(Int.self, forKey: .myAnimeListId)
        self.ratesScoresStats = try container.decodeIfPresent([SwikiRateScore].self, forKey: .ratesScoresStats) ?? []
        self.ratesStatusesStats = try container.decodeIfPresent([SwikiRateStatus].self, forKey: .ratesStatusesStats) ?? []
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        self.licensors = try container.decodeIfPresent([String].self, forKey: .licensors) ?? []
        self.genres = try container.decodeIfPresent([SwikiGenre].self, forKey: .genres) ?? []
        self.publishers = try container.decodeIfPresent([SwikiPublisher].self, forKey: .publishers) ?? []
        self.userRate = try container.decodeIfPresent(SwikiUserRate.self, forKey: .userRate)
    }
}
