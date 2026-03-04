import Foundation
import Logging
import Swiki
import SwikiModels

@MainActor
final class ExampleAppViewModel: ObservableObject {
    @Published var clientID: String = ""
    @Published var clientSecret: String = ""
    @Published var redirectURI: String = "swikiexample://oauth/callback"
    @Published var userAgent: String = "SwikiExampleApp/1.0 (example@example.com)"

    @Published var animeSearch: String = "bakemonogatari"
    @Published var animeLimit: Int = 3

    @Published private(set) var isClientReady: Bool = false
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var accessTokenPreview: String = "Not authorized"
    @Published private(set) var whoamiName: String?
    @Published private(set) var animeNames: [String] = []
    @Published private(set) var graphQLAnimesIDs: [String] = []
    @Published private(set) var logs: [String] = []
    @Published var errorMessage: String?

    private let apiLogger: Logger
    private var swiki: Swiki?

    var canStartOAuth: Bool {
        !clientID.isEmpty && !clientSecret.isEmpty && !redirectURI.isEmpty && isClientReady
    }

    init() {
        var logger = Logger(label: "io.swiki.example.api")
        logger.logLevel = .debug
        apiLogger = logger

        recreateClient()
    }

    func recreateClient() {
        let configuration: SwikiConfiguration
        if clientID.isEmpty || clientSecret.isEmpty || redirectURI.isEmpty {
            configuration = SwikiConfiguration(
                userAgent: userAgent,
                apiLogger: apiLogger
            )
            appendLog("Swiki client recreated without OAuth credentials")
        } else {
            let credentials = SwikiOAuthCredentials(
                clientId: clientID,
                clientSecret: clientSecret,
                redirectURI: redirectURI
            )
            configuration = SwikiConfiguration(
                oauthCredentials: credentials,
                userAgent: userAgent,
                apiLogger: apiLogger
            )
            appendLog("Swiki client recreated with OAuth credentials")
        }

        swiki = Swiki(configuration: configuration)
        isClientReady = true
    }

    func loginWithOAuth() async {
        guard let swiki, let oauth = swiki.oauth else {
            show("OAuth is not configured. Fill Client ID / Secret / Redirect URI and recreate client.")
            return
        }

        await perform("OAuth login started") {
            let token = try await oauth.authorizeWithWebAuthenticationSession(
                scopes: [.userRates, .comments, .topics],
                prefersEphemeralWebBrowserSession: false
            )
            accessTokenPreview = tokenPreview(token.accessToken)
            appendLog("OAuth login finished. Expires at \(token.expiresAt)")
        }
    }

    func loadWhoami() async {
        guard let swiki else {
            show("Swiki client is not ready")
            return
        }

        await perform("Loading whoami") {
            let me = try await swiki.v1.whoami.get()
            whoamiName = me.nickname
            appendLog("Loaded whoami: \(me.nickname)")
        }
    }

    func searchAnimes() async {
        guard let swiki else {
            show("Swiki client is not ready")
            return
        }

        await perform("Searching animes for '\(animeSearch)'") {
            let query = SwikiV1AnimesQuery(
                limit: animeLimit,
                search: animeSearch
            )
            let items = try await swiki.v1.animes.get(query: query)
            animeNames = items.map(\.name)
            appendLog("Loaded \(items.count) anime items")
        }
    }

    func loadGraphQLUserRates() async {
        guard let swiki else {
            show("Swiki client is not ready")
            return
        }

        await perform("Running GraphQL DefaultUserRatesOperation") {
            let operation = SwikiGraphQLOperations.DefaultAnimesOperation(
                variables: SwikiGraphQLOperations.DefaultAnimesOperation.Variables(search: "bakemonogatari")
            )
            let data = try await swiki.graphQL.execute(operation: operation)
            graphQLAnimesIDs = data.animes.map(\.id)
            appendLog("GraphQL loaded \(data.animes.count) user rates")
        }
    }

    private func perform(_ startMessage: String, operation: () async throws -> Void) async {
        isLoading = true
        errorMessage = nil
        appendLog(startMessage)
        do {
            try await operation()
        } catch {
            show(error)
        }
        isLoading = false
    }

    private func tokenPreview(_ token: String) -> String {
        let prefix = token.prefix(8)
        return "\(prefix)..."
    }

    private func show(_ value: String) {
        errorMessage = value
        appendLog("Error: \(value)")
    }

    private func show(_ error: Error) {
        show(error.localizedDescription)
    }

    private func appendLog(_ message: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        logs.insert("[\(formatter.string(from: Date()))] \(message)", at: 0)
    }
}
