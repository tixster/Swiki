import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public actor SwikiOAuthClient {
    public let credentials: SwikiOAuthCredentials
    public let baseURL: URL

    private let session: URLSession
    private let tokenStore: (any SwikiOAuthTokenStore)?
    private var token: SwikiOAuthToken?
    private var isTokenLoadedFromStore = false

    init(
        credentials: SwikiOAuthCredentials,
        baseURL: URL = SwikiConfig.baseDomen,
        tokenStore: (any SwikiOAuthTokenStore)? = nil,
        session: URLSession = .shared
    ) {
        self.credentials = credentials
        self.baseURL = baseURL
        self.token = nil
        self.tokenStore = tokenStore
        self.isTokenLoadedFromStore = false
        self.session = session
    }

    public func authorizationURL(
        scopes: [SwikiOAuthScope],
    ) throws -> URL {
        guard var components = URLComponents(url: oauthURL(path: "oauth/authorize"), resolvingAgainstBaseURL: false) else {
            throw SwikiOAuthError.invalidAuthorizeURL
        }

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "client_id", value: credentials.clientId),
            URLQueryItem(name: "redirect_uri", value: credentials.redirectURI),
            URLQueryItem(name: "response_type", value: "code")
        ]

        if !scopes.isEmpty {
            let scopeValue = scopes.map(\.rawValue).joined(separator: "+")
            queryItems.append(URLQueryItem(name: "scope", value: scopeValue))
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw SwikiOAuthError.invalidAuthorizeURL
        }

        return url
    }

    public func currentToken() async throws -> SwikiOAuthToken? {
        try await loadTokenFromStoreIfNeeded()
        return token
    }

    public func setToken(_ token: SwikiOAuthToken?) async throws {
        self.token = token
        self.isTokenLoadedFromStore = true
        try await persistToken()
    }

    public func exchangeCode(_ code: String) async throws -> SwikiOAuthToken {
        let nextToken = try await tokenRequest(
            grantType: "authorization_code",
            extra: [
                "code": code,
                "redirect_uri": credentials.redirectURI
            ]
        )
        token = nextToken
        isTokenLoadedFromStore = true
        try await persistToken()
        return nextToken
    }

    @discardableResult
    public func refreshToken() async throws -> SwikiOAuthToken {
        guard let refreshToken = token?.refreshToken, !refreshToken.isEmpty else {
            throw SwikiOAuthError.missingRefreshToken
        }

        let nextToken = try await tokenRequest(
            grantType: "refresh_token",
            extra: [
                "refresh_token": refreshToken
            ]
        )
        token = nextToken
        isTokenLoadedFromStore = true
        try await persistToken()
        return nextToken
    }

    func validAccessToken() async throws -> String? {
        try await loadTokenFromStoreIfNeeded()

        guard let token else {
            return nil
        }

        if token.isExpired(), let refreshToken = token.refreshToken, !refreshToken.isEmpty {
            let nextToken = try await tokenRequest(
                grantType: "refresh_token",
                extra: ["refresh_token": refreshToken]
            )
            self.token = nextToken
            isTokenLoadedFromStore = true
            try await persistToken()
            return nextToken.accessToken
        }

        return token.accessToken
    }

    func refreshTokenIfPossible() async throws -> Bool {
        try await loadTokenFromStoreIfNeeded()

        guard let refreshToken = token?.refreshToken, !refreshToken.isEmpty else {
            return false
        }

        let nextToken = try await tokenRequest(
            grantType: "refresh_token",
            extra: ["refresh_token": refreshToken]
        )
        token = nextToken
        isTokenLoadedFromStore = true
        try await persistToken()
        return true
    }

    private func loadTokenFromStoreIfNeeded() async throws {
        guard !isTokenLoadedFromStore else {
            return
        }

        isTokenLoadedFromStore = true
        if token == nil {
            token = try await tokenStore?.loadToken()
        }
    }

    private func persistToken() async throws {
        try await tokenStore?.saveToken(token)
    }

    private func tokenRequest(
        grantType: String,
        extra: [String: String]
    ) async throws -> SwikiOAuthToken {
        let endpoint = oauthURL(path: "oauth/token")
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

        var items: [URLQueryItem] = [
            URLQueryItem(name: "grant_type", value: grantType),
            URLQueryItem(name: "client_id", value: credentials.clientId),
            URLQueryItem(name: "client_secret", value: credentials.clientSecret)
        ]
        items.append(contentsOf: extra.map { URLQueryItem(name: $0.key, value: $0.value) })
        request.httpBody = Self.formURLEncodedData(items: items)

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw SwikiOAuthError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let responseBody = data.isEmpty ? nil : String(data: data, encoding: .utf8)
            throw SwikiOAuthError.badStatusCode(httpResponse.statusCode, responseBody)
        }

        return try JSONDecoder().decode(SwikiOAuthToken.self, from: data)
    }

    private func oauthURL(path: String) -> URL {
        var url = baseURL
        path.split(separator: "/").forEach { component in
            url.appendPathComponent(String(component))
        }
        return url
    }

    private static func formURLEncodedData(items: [URLQueryItem]) -> Data? {
        var components = URLComponents()
        components.queryItems = items
        return components.percentEncodedQuery?.data(using: .utf8)
    }
}
