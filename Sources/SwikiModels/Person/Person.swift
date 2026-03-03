import Foundation

public struct SwikiPersonGroupedRole: Decodable, Sendable {
    public let role: String
    public let count: Int

    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.role = try container.decode(String.self)

        if let intValue = try? container.decode(Int.self) {
            self.count = intValue
        } else if let stringValue = try? container.decode(String.self), let intValue = Int(stringValue) {
            self.count = intValue
        } else {
            throw DecodingError.typeMismatch(
                Int.self,
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Expected Int or String for grouped role count"
                )
            )
        }
    }
}

public struct SwikiPersonRoleEntry: Decodable, Sendable {
    public let characters: [SwikiCharacter]?
    public let animes: [SwikiAnimeV1Preview]?
    public let mangas: [SwikiUserLinked]?
}

public struct SwikiPerson: Decodable, Sendable {
    public let id: String
    public let name: String
    public let russian: String?
    public let image: SwikiImage?
    public let url: URL?
    public let japanese: String?
    public let jobTitle: String?
    public let birthOn: SwikiIncompleteDate?
    public let deceasedOn: SwikiIncompleteDate?
    public let birthday: SwikiIncompleteDate?
    public let website: String?
    public let grouppedRoles: [SwikiPersonGroupedRole]?
    public let roles: [SwikiPersonRoleEntry]?
    public let works: [SwikiPersonWork]?
    public let threadId: String?
    public let topicId: String?
    public let personFavoured: Bool
    public let producer: Bool
    public let producerFavoured: Bool
    public let mangaka: Bool
    public let mangakaFavoured: Bool
    public let seyu: Bool
    public let seyuFavoured: Bool
    public let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case russian
        case image
        case url
        case japanese
        case jobTitle = "job_title"
        case birthOn = "birth_on"
        case deceasedOn = "deceased_on"
        case birthday
        case website
        case grouppedRoles = "groupped_roles"
        case roles
        case works
        case threadId = "thread_id"
        case topicId = "topic_id"
        case personFavoured = "person_favoured"
        case producer
        case producerFavoured = "producer_favoured"
        case mangaka
        case mangakaFavoured = "mangaka_favoured"
        case seyu
        case seyuFavoured = "seyu_favoured"
        case updatedAt = "updated_at"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian)
        self.image = try container.decodeIfPresent(SwikiImage.self, forKey: .image)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.japanese = try container.decodeIfPresent(String.self, forKey: .japanese)
        self.jobTitle = try container.decodeIfPresent(String.self, forKey: .jobTitle)
        self.birthOn = try container.decodeIfPresent(SwikiIncompleteDate.self, forKey: .birthOn)
        self.deceasedOn = try container.decodeIfPresent(SwikiIncompleteDate.self, forKey: .deceasedOn)
        self.birthday = try? container.decodeIfPresent(SwikiIncompleteDate.self, forKey: .birthday)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
        self.grouppedRoles = try container.decodeIfPresent([SwikiPersonGroupedRole].self, forKey: .grouppedRoles)
        self.roles = try container.decodeIfPresent([SwikiPersonRoleEntry].self, forKey: .roles)
        self.works = try container.decodeIfPresent([SwikiPersonWork].self, forKey: .works)
        self.threadId = try container.decodeStringOrIntIfPresent(forKey: .threadId)
        self.topicId = try container.decodeStringOrIntIfPresent(forKey: .topicId)
        self.personFavoured = try container.decodeIfPresent(Bool.self, forKey: .personFavoured) ?? false
        self.producer = try container.decodeIfPresent(Bool.self, forKey: .producer) ?? false
        self.producerFavoured = try container.decodeIfPresent(Bool.self, forKey: .producerFavoured) ?? false
        self.mangaka = try container.decodeIfPresent(Bool.self, forKey: .mangaka) ?? false
        self.mangakaFavoured = try container.decodeIfPresent(Bool.self, forKey: .mangakaFavoured) ?? false
        self.seyu = try container.decodeIfPresent(Bool.self, forKey: .seyu) ?? false
        self.seyuFavoured = try container.decodeIfPresent(Bool.self, forKey: .seyuFavoured) ?? false
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
    }
}
