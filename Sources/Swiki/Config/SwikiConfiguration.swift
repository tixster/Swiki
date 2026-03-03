import Foundation

public struct SwikiConfiguration: Sendable {
    /// OAuth2 Credentials
    ///
    /// Брать отсюда https://shikimori.io/oauth/applications/ID-приложения/edit
    public let clientId: String?
    public let accessToken: String?
    public let oauthCredentials: SwikiOAuthCredentials?
    public let oauthTokenStore: (any SwikiOAuthTokenStore)?
    public let oauthBaseURL: URL
    public let userAgent: String
    public let baseURL: URL
    public let additionalHeaders: [String: String]

    public init(
        clientId: String? = nil,
        accessToken: String? = nil,
        oauthCredentials: SwikiOAuthCredentials? = nil,
        oauthTokenStore: (any SwikiOAuthTokenStore)? = nil,
        oauthBaseURL: URL = SwikiConfig.baseDomen,
        userAgent: String,
        baseURL: URL = SwikiConfig.baseDomen.appendingPathComponent("api"),
        additionalHeaders: [String: String] = [:]
    ) {
        self.clientId = clientId
        self.accessToken = accessToken
        self.oauthCredentials = oauthCredentials
        self.oauthTokenStore = oauthTokenStore
        self.oauthBaseURL = oauthBaseURL
        self.userAgent = userAgent
        self.baseURL = baseURL
        self.additionalHeaders = additionalHeaders
    }

}
