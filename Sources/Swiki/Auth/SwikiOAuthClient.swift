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
    private var loadTokenTask: Task<SwikiOAuthToken?, any Error>?
    private var refreshTask: Task<SwikiOAuthToken, any Error>?

    init(
        credentials: SwikiOAuthCredentials,
        baseURL: URL = SwikiConstant.baseDomen,
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
        try await loadTokenFromStoreIfNeeded()

        guard let refreshToken = token?.refreshToken, !refreshToken.isEmpty else {
            throw SwikiOAuthError.missingRefreshToken
        }

        return try await refreshAccessToken(using: refreshToken)
    }

    func validAccessToken() async throws -> String? {
        try await loadTokenFromStoreIfNeeded()

        guard let token else {
            return nil
        }

        if token.isExpired(), let refreshToken = token.refreshToken, !refreshToken.isEmpty {
            let nextToken = try await refreshAccessToken(using: refreshToken)
            return nextToken.accessToken
        }

        return token.accessToken
    }

    func refreshTokenIfPossible() async throws -> Bool {
        try await loadTokenFromStoreIfNeeded()

        guard let refreshToken = token?.refreshToken, !refreshToken.isEmpty else {
            return false
        }

        _ = try await refreshAccessToken(using: refreshToken)
        return true
    }

    private func refreshAccessToken(using refreshToken: String) async throws -> SwikiOAuthToken {
        if let refreshTask {
            return try await refreshTask.value
        }

        let refreshTask = Task { [credentials, baseURL, session] in
            try await Self.tokenRequest(
                credentials: credentials,
                baseURL: baseURL,
                session: session,
                grantType: "refresh_token",
                extra: ["refresh_token": refreshToken]
            )
        }
        self.refreshTask = refreshTask
        defer { self.refreshTask = nil }

        let nextToken = try await refreshTask.value
        token = nextToken
        isTokenLoadedFromStore = true
        try await persistToken()
        return nextToken
    }

    private func loadTokenFromStoreIfNeeded() async throws {
        if isTokenLoadedFromStore {
            return
        }

        if let loadTokenTask {
            let loadedToken = try await loadTokenTask.value
            if token == nil {
                token = loadedToken
            }
            isTokenLoadedFromStore = true
            return
        }

        let loadTokenTask = Task { [tokenStore] in
            try await tokenStore?.loadToken()
        }
        self.loadTokenTask = loadTokenTask
        defer { self.loadTokenTask = nil }

        let loadedToken = try await loadTokenTask.value
        if token == nil {
            token = loadedToken
        }
        isTokenLoadedFromStore = true
    }

    private func persistToken() async throws {
        try await tokenStore?.saveToken(token)
    }

    private func tokenRequest(
        grantType: String,
        extra: [String: String]
    ) async throws -> SwikiOAuthToken {
        try await Self.tokenRequest(
            credentials: credentials,
            baseURL: baseURL,
            session: session,
            grantType: grantType,
            extra: extra
        )
    }

    private static func tokenRequest(
        credentials: SwikiOAuthCredentials,
        baseURL: URL,
        session: URLSession,
        grantType: String,
        extra: [String: String]
    ) async throws -> SwikiOAuthToken {
        let endpoint = oauthURL(baseURL: baseURL, path: "oauth/token")
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
        Self.oauthURL(baseURL: baseURL, path: path)
    }

    private static func oauthURL(baseURL: URL, path: String) -> URL {
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
