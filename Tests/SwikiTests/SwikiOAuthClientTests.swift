import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Testing
@testable import Swiki

@Suite("SwikiOAuthClient")
struct SwikiOAuthClientTests {
    @Test
    func authorizationURLIncludesClientRedirectAndScopes() async throws {
        let client = makeClient()

        let url = try await client.authorizationURL(scopes: [.userRates, .comments])
        let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
        let queryItems = queryItemsByName(components.queryItems)

        #expect(url.path == "/oauth/authorize")
        #expect(queryItems["client_id"] == "client-id")
        #expect(queryItems["redirect_uri"] == "swiki://oauth")
        #expect(queryItems["response_type"] == "code")
        #expect(queryItems["scope"] == "user_rates+comments")
    }

    @Test
    func exchangeCodePersistsReturnedTokenAndSendsAuthorizationCodeForm() async throws {
        let baseURL = uniqueBaseURL()
        let host = try #require(baseURL.host())
        let returnedToken = makeToken(accessToken: "exchanged-access", refreshToken: "exchanged-refresh")
        try await MockOAuthURLProtocol.registry.register(
            host: host,
            stubs: [.json(returnedToken)]
        )
        let tokenStore = InMemoryOAuthTokenStore()
        let client = makeClient(baseURL: baseURL, tokenStore: tokenStore)

        let token = try await client.exchangeCode("authorization-code")

        #expect(token.accessToken == "exchanged-access")
        #expect(await tokenStore.currentToken()?.accessToken == "exchanged-access")

        let requests = await MockOAuthURLProtocol.registry.requests(for: host)
        let request = try #require(requests.first)
        let form = formValues(from: request.body)

        #expect(requests.count == 1)
        #expect(request.method == "POST")
        #expect(request.path == "/oauth/token")
        #expect(form["grant_type"] == "authorization_code")
        #expect(form["client_id"] == "client-id")
        #expect(form["client_secret"] == "client-secret")
        #expect(form["code"] == "authorization-code")
        #expect(form["redirect_uri"] == "swiki://oauth")
    }

    @Test
    func validAccessTokenLoadsStoredTokenOnceForSequentialCalls() async throws {
        let baseURL = uniqueBaseURL()
        let host = try #require(baseURL.host())
        let storedToken = makeToken(accessToken: "stored-access", refreshToken: "stored-refresh")
        let tokenStore = InMemoryOAuthTokenStore(token: storedToken)
        let client = makeClient(baseURL: baseURL, tokenStore: tokenStore)

        let firstAccessToken = try await client.validAccessToken()
        let secondAccessToken = try await client.validAccessToken()

        #expect(firstAccessToken == "stored-access")
        #expect(secondAccessToken == "stored-access")
        #expect(await tokenStore.loadCount == 1)
        #expect(await MockOAuthURLProtocol.registry.requests(for: host).isEmpty)
    }

    @Test
    func validAccessTokenSharesConcurrentStoreLoad() async throws {
        let storedToken = makeToken(accessToken: "stored-access", refreshToken: "stored-refresh")
        let tokenStore = InMemoryOAuthTokenStore(token: storedToken, loadDelay: .milliseconds(100))
        let client = makeClient(tokenStore: tokenStore)

        let accessTokens = try await collectConcurrentResults(count: 10) {
            try await client.validAccessToken()
        }

        #expect(accessTokens.allSatisfy { $0 == "stored-access" })
        #expect(await tokenStore.loadCount == 1)
    }

    @Test
    func expiredTokenRefreshIsSingleFlightForConcurrentCallers() async throws {
        let baseURL = uniqueBaseURL()
        let host = try #require(baseURL.host())
        let expiredToken = makeToken(
            accessToken: "expired-access",
            refreshToken: "refresh-token",
            createdAt: Int(Date().timeIntervalSince1970) - 3_600,
            expiresIn: 10
        )
        let refreshedToken = makeToken(accessToken: "refreshed-access", refreshToken: "next-refresh")
        try await MockOAuthURLProtocol.registry.register(
            host: host,
            stubs: [.json(refreshedToken, delay: .milliseconds(100))]
        )
        let tokenStore = InMemoryOAuthTokenStore(token: expiredToken)
        let client = makeClient(baseURL: baseURL, tokenStore: tokenStore)

        let accessTokens = try await collectConcurrentResults(count: 10) {
            try await client.validAccessToken()
        }

        #expect(accessTokens.allSatisfy { $0 == "refreshed-access" })
        #expect(await tokenStore.currentToken()?.accessToken == "refreshed-access")
        #expect(await tokenStore.loadCount == 1)
        #expect(await tokenStore.saveCount == 1)

        let requests = await MockOAuthURLProtocol.registry.requests(for: host)
        let request = try #require(requests.first)
        let form = formValues(from: request.body)

        #expect(requests.count == 1)
        #expect(request.path == "/oauth/token")
        #expect(form["grant_type"] == "refresh_token")
        #expect(form["refresh_token"] == "refresh-token")
    }
}

private func makeClient(
    baseURL: URL = uniqueBaseURL(),
    tokenStore: (any SwikiOAuthTokenStore)? = nil
) -> SwikiOAuthClient {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockOAuthURLProtocol.self]
    let session = URLSession(configuration: configuration)

    return SwikiOAuthClient(
        credentials: .init(
            clientId: "client-id",
            clientSecret: "client-secret",
            redirectURI: "swiki://oauth"
        ),
        baseURL: baseURL,
        tokenStore: tokenStore,
        session: session
    )
}

private func makeToken(
    accessToken: String,
    refreshToken: String?,
    createdAt: Int = Int(Date().timeIntervalSince1970),
    expiresIn: Int = 3_600
) -> SwikiOAuthToken {
    SwikiOAuthToken(
        accessToken: accessToken,
        tokenType: "Bearer",
        refreshToken: refreshToken,
        scope: nil,
        createdAt: createdAt,
        expiresIn: expiresIn
    )
}

private func uniqueBaseURL() -> URL {
    URL(string: "https://oauth-\(UUID().uuidString.lowercased()).example")!
}

private func queryItemsByName(_ queryItems: [URLQueryItem]?) -> [String: String] {
    Dictionary(uniqueKeysWithValues: (queryItems ?? []).map { ($0.name, $0.value ?? "") })
}

private func formValues(from body: Data?) -> [String: String] {
    guard
        let body,
        let form = String(data: body, encoding: .utf8),
        let components = URLComponents(string: "https://example.test?\(form)")
    else {
        return [:]
    }

    return queryItemsByName(components.queryItems)
}

private func collectConcurrentResults<Value: Sendable>(
    count: Int,
    operation: @Sendable @escaping () async throws -> Value
) async throws -> [Value] {
    try await withThrowingTaskGroup(of: Value.self) { group in
        for _ in 0..<count {
            group.addTask {
                try await operation()
            }
        }

        var values: [Value] = []
        for try await value in group {
            values.append(value)
        }
        return values
    }
}

private actor InMemoryOAuthTokenStore: SwikiOAuthTokenStore {
    private var token: SwikiOAuthToken?
    private let loadDelay: Duration
    private var loadCallCount = 0
    private var saveCallCount = 0

    init(token: SwikiOAuthToken? = nil, loadDelay: Duration = .zero) {
        self.token = token
        self.loadDelay = loadDelay
    }

    var loadCount: Int {
        loadCallCount
    }

    var saveCount: Int {
        saveCallCount
    }

    func currentToken() -> SwikiOAuthToken? {
        token
    }

    func loadToken() async throws -> SwikiOAuthToken? {
        loadCallCount += 1
        if loadDelay > .zero {
            try await Task.sleep(for: loadDelay)
        }
        return token
    }

    func saveToken(_ token: SwikiOAuthToken?) async throws {
        saveCallCount += 1
        self.token = token
    }
}

private struct MockOAuthStub: Sendable {
    var statusCode: Int
    var headers: [String: String]
    var data: Data
    var delay: Duration

    static func json<T: Encodable & Sendable>(
        _ value: T,
        statusCode: Int = 200,
        delay: Duration = .zero
    ) throws -> MockOAuthStub {
        MockOAuthStub(
            statusCode: statusCode,
            headers: ["Content-Type": "application/json"],
            data: try JSONEncoder().encode(value),
            delay: delay
        )
    }
}

private struct RecordedOAuthRequest: Sendable {
    var method: String?
    var path: String
    var body: Data?
}

private actor MockOAuthURLProtocolRegistry {
    private var stubsByHost: [String: [MockOAuthStub]] = [:]
    private var requestsByHost: [String: [RecordedOAuthRequest]] = [:]

    func register(host: String, stubs: [MockOAuthStub]) {
        stubsByHost[host] = stubs
        requestsByHost[host] = []
    }

    func nextStub(host: String, request: RecordedOAuthRequest) throws -> MockOAuthStub {
        requestsByHost[host, default: []].append(request)

        guard var stubs = stubsByHost[host], !stubs.isEmpty else {
            throw MockOAuthURLProtocolError.missingStub(host: host)
        }

        let stub = stubs.removeFirst()
        stubsByHost[host] = stubs
        return stub
    }

    func requests(for host: String) -> [RecordedOAuthRequest] {
        requestsByHost[host, default: []]
    }
}

private enum MockOAuthURLProtocolError: Error {
    case missingURL
    case missingStub(host: String)
    case invalidResponse
}

private final class MockOAuthURLProtocol: URLProtocol, @unchecked Sendable {
    static let registry = MockOAuthURLProtocolRegistry()

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let url = request.url, let host = url.host else {
            client?.urlProtocol(self, didFailWithError: MockOAuthURLProtocolError.missingURL)
            return
        }

        let recordedRequest = RecordedOAuthRequest(
            method: request.httpMethod,
            path: url.path,
            body: Self.bodyData(from: request)
        )

        Task {
            do {
                let stub = try await Self.registry.nextStub(host: host, request: recordedRequest)
                if stub.delay > .zero {
                    try await Task.sleep(for: stub.delay)
                }

                guard let response = HTTPURLResponse(
                    url: url,
                    statusCode: stub.statusCode,
                    httpVersion: nil,
                    headerFields: stub.headers
                ) else {
                    throw MockOAuthURLProtocolError.invalidResponse
                }

                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: stub.data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }

    override func stopLoading() {}

    private static func bodyData(from request: URLRequest) -> Data? {
        if let httpBody = request.httpBody {
            return httpBody
        }

        guard let stream = request.httpBodyStream else {
            return nil
        }

        stream.open()
        defer { stream.close() }

        var data = Data()
        var buffer = [UInt8](repeating: 0, count: 1_024)
        while stream.hasBytesAvailable {
            let count = stream.read(&buffer, maxLength: buffer.count)
            if count > 0 {
                data.append(buffer, count: count)
            } else {
                break
            }
        }
        return data
    }
}
