import Foundation

public struct SwikiOAuthCredentials: Sendable {
    public let clientId: String
    public let clientSecret: String
    public let redirectURI: String

    public init(
        clientId: String,
        clientSecret: String,
        redirectURI: String
    ) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
    }
}

public struct SwikiOAuthToken: Codable, Sendable {
    public let accessToken: String
    public let tokenType: String
    public let refreshToken: String?
    public let scope: String?
    public let createdAt: Int
    public let expiresIn: Int

    public init(
        accessToken: String,
        tokenType: String,
        refreshToken: String?,
        scope: String?,
        createdAt: Int,
        expiresIn: Int
    ) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.refreshToken = refreshToken
        self.scope = scope
        self.createdAt = createdAt
        self.expiresIn = expiresIn
    }

    public var expiresAt: Date {
        Date(timeIntervalSince1970: TimeInterval(createdAt + expiresIn))
    }

    public func isExpired(leeway: TimeInterval = 30, now: Date = Date()) -> Bool {
        expiresAt.addingTimeInterval(-leeway) <= now
    }

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case scope
        case createdAt = "created_at"
        case expiresIn = "expires_in"
    }
}

public struct SwikiOAuthScope: RawRepresentable, Hashable, Sendable, ExpressibleByStringLiteral {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

public extension SwikiOAuthScope {
    static let userRates: SwikiOAuthScope = "user_rates"
    static let comments: SwikiOAuthScope = "comments"
    static let topics: SwikiOAuthScope = "topics"
    static let ignores: SwikiOAuthScope = "ignores"
    static let clubs: SwikiOAuthScope = "clubs"
    static let friends: SwikiOAuthScope = "friends"
    static let messages: SwikiOAuthScope = "messages"
    static let styles: SwikiOAuthScope = "styles"
}

