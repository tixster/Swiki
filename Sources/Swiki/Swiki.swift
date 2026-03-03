import Foundation

public enum SwikiConfig {
    public static let baseDomen: URL = URL(string: "https://shikimori.io")!
}

/**
 Клиент Shikimori API.

 Использование:
 - `swiki.v1.<resource>` для методов API v1
 - `swiki.v2.<resource>` для методов API v2
 */
public final class Swiki: Sendable {
    public let v1: SwikiV1Client
    public let v2: SwikiV2Client
    public let oauth: SwikiOAuthClient?

    public init(
        configuration: SwikiConfiguration,
        session: URLSession = .shared
    ) {
        let oauthClient: SwikiOAuthClient?
        if let oauthCredentials = configuration.oauthCredentials {
            let defaultTokenStore: (any SwikiOAuthTokenStore)?
            #if canImport(Security) && (os(iOS) || os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
            defaultTokenStore = SwikiKeychainOAuthTokenStore(
                account: "oauth.token.\(oauthCredentials.clientId)"
            )
            #else
            defaultTokenStore = nil
            #endif

            oauthClient = SwikiOAuthClient(
                credentials: oauthCredentials,
                baseURL: configuration.oauthBaseURL,
                tokenStore: configuration.oauthTokenStore ?? defaultTokenStore,
                session: session
            )
        } else {
            oauthClient = nil
        }

        let transport = SwikiHTTPTransport(
            configuration: configuration,
            session: session,
            oauthClient: oauthClient
        )
        self.v1 = SwikiV1Client(transport: transport)
        self.v2 = SwikiV2Client(transport: transport)
        self.oauth = oauthClient
    }
}
