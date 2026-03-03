import Foundation

public struct SwikiConfiguration: Sendable {
    /// OAuth2 Credentials
    ///
    /// Брать отсюда https://shikimori.one/oauth/applications/ID-приложения/edit
    public let clientId: String?
    public let accessToken: String?
    public let userAgent: String
    public let isRpsRpmRestrictionsEnabled: Bool
    public let baseURL: URL
    public let additionalHeaders: [String: String]

    public init(
        clientId: String? = nil,
        accessToken: String? = nil,
        userAgent: String,
        isRpsRpmRestrictionsEnabled: Bool = true,
        baseURL: URL = URL(string: "https://shikimori.one/api")!,
        additionalHeaders: [String: String] = [:]
    ) {
        self.clientId = clientId
        self.accessToken = accessToken
        self.userAgent = userAgent
        self.isRpsRpmRestrictionsEnabled = isRpsRpmRestrictionsEnabled
        self.baseURL = baseURL
        self.additionalHeaders = additionalHeaders
    }

}
