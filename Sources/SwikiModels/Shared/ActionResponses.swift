import Foundation

public struct SwikiNoticeResponse: Decodable, Sendable {
    public let success: Bool?
    public let notice: String?
}

public struct SwikiTopicIgnoreCreateResponse: Decodable, Sendable {
    public let id: String?
    public let url: URL?
    public let method: String?

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case method
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrIntIfPresent(forKey: .id)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.method = try container.decodeIfPresent(String.self, forKey: .method)
    }
}

public struct SwikiTopicIgnoreDeleteResponse: Decodable, Sendable {
    public let url: URL?
    public let method: String?
}

public struct SwikiUserImageUploadResponse: Decodable, Sendable {
    public let id: String
    public let preview: URL?
    public let url: URL?
    public let bbcode: String

    enum CodingKeys: String, CodingKey {
        case id
        case preview
        case url
        case bbcode
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeStringOrInt(forKey: .id)
        self.preview = try container.decodeIfPresent(URL.self, forKey: .preview)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.bbcode = try container.decode(String.self, forKey: .bbcode)
    }
}

public struct SwikiEmptyResponse: Decodable, Sendable {
    public init() {}
}

public struct SwikiAbuseOfftopicResponse: Decodable, Sendable {
    public let kind: String
    public let value: Bool
    public let affectedIds: [String]

    enum CodingKeys: String, CodingKey {
        case kind
        case value
        case affectedIds = "affected_ids"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.value = try container.decode(Bool.self, forKey: .value)

        if let ids = try? container.decode([String].self, forKey: .affectedIds) {
            self.affectedIds = ids
        } else if let ids = try? container.decode([Int].self, forKey: .affectedIds) {
            self.affectedIds = ids.map(String.init)
        } else {
            self.affectedIds = []
        }
    }
}
