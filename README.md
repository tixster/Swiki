# Swiki
Typed Swift client for the Shikimori API (`v1`, `v2`, `GraphQL`) with OAuth2 support, automatic token refresh, and GraphQL operation generation.

<p align="center">
  <a href="README.md">
    <img src="https://img.shields.io/badge/Language-English-0A66C2?style=for-the-badge" alt="Language: English">
  </a>
  <a href="README.ru.md">
    <img src="https://img.shields.io/badge/Язык-Русский-1F883D?style=for-the-badge" alt="Язык: Русский">
  </a>
</p>

![Swift](https://img.shields.io/badge/Swift-6.2-orange?logo=swift)
[![SPDX](https://img.shields.io/badge/SPDX-MIT-blue.svg)](https://spdx.org/licenses/MIT.html)
![Platforms](https://img.shields.io/badge/platforms-iOS%2016%20%7C%20macOS%2013%20%7C%20tvOS%2016%20%7C%20watchOS%209%20%7C%20Linux-orange)
![API](https://img.shields.io/badge/API-V1%20%7C%20V2%20%7C%20GraphQL-orange?logo=shikimori)
[![CI](https://github.com/Tixster/Swiki/actions/workflows/ci.yml/badge.svg)](https://github.com/Tixster/Swiki/actions/workflows/ci.yml)

## Features
- API versioned clients: `swiki.v1`, `swiki.v2`, `swiki.graphQL`.
- Dedicated subclients per resource (`users`, `animes`, `userRates`, `topicIgnore`, etc.).
- Unified CRUD interface (`list`, `get`, `create`, `update`, `delete`) plus resource-specific methods.
- OAuth2:
  - exchange `authorization_code` for a token,
  - manual and automatic token refresh,
  - `ASWebAuthenticationSession` on Apple platforms.
- Token storage via `SwikiOAuthTokenStore`:
  - Keychain by default on Apple platforms,
  - custom storage for other platforms.
- GraphQL:
  - raw queries,
  - typed operations (`SwikiGraphQLOperation`),
  - generate operations from `.graphql` files (one `.swift` file per operation).

## Requirements
- Swift `6.2+`
- Platforms:
  - iOS 16+
  - macOS 13+
  - tvOS 16+
  - watchOS 9+
  - Linux

## Installation (Swift Package Manager)
```swift
dependencies: [
    .package(url: "https://github.com/Tixster/Swiki.git", .upToNextMajor(from: "1.0.0"))
]
```

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "Swiki", package: "Swiki")
        ]
    )
]
```

If you only need the models:
```swift
.product(name: "SwikiModels", package: "Swiki")
```

## Quick Start
```swift
import Swiki

let config = SwikiConfiguration(
    userAgent: "MyApp/1.0 (me@example.com)"
)

let swiki = Swiki(configuration: config)

let users = try await swiki.v1.users.get(
    query: SwikiV1UsersQuery(
        search: "kirito",
        limit: 5
    )
)
```

## Configuration
`SwikiConfiguration`:
- `userAgent` (required)
- `clientId` / `accessToken` (static authorization)
- `oauthCredentials` + `oauthTokenStore` (OAuth2)
- `oauthBaseURL` (default: `https://shikimori.io`)
- `graphQLURL` (default: `https://shikimori.io/api/graphql`)
- `baseURL` (default: `https://shikimori.io/api`)
- `apiLogger` (`swift-log` `Logger` for API request logging)
- `additionalHeaders`
- `isRpsRpmRestrictionsEnabled` (`true` by default)

### API Logging (`swift-log`)
```swift
import Swiki
import Logging

LoggingSystem.bootstrap(StreamLogHandler.standardOutput)

let logger = Logger(label: "com.example.swiki.api")

let config = SwikiConfiguration(
    userAgent: "MyApp/1.0 (me@example.com)",
    apiLogger: logger
)
```

Log metadata includes: `kind`, `method`, `url`, `attempt`, `status`, `duration_ms`, request/response body size, and error text.

## OAuth2
### 1) Initialization
```swift
import Swiki

let credentials = SwikiOAuthCredentials(
    clientId: "<client_id>",
    clientSecret: "<client_secret>",
    redirectURI: "myapp://oauth-callback"
)

let config = SwikiConfiguration(
    userAgent: "MyApp/1.0 (me@example.com)",
    oauthCredentials: credentials
)

let swiki = Swiki(configuration: config)
```

### 2) Apple platforms: `ASWebAuthenticationSession`
```swift
#if canImport(AuthenticationServices)
let token = try await swiki.oauth?.authorizeWithWebAuthenticationSession(
    scopes: [.userRates, .comments, .topics]
)
#endif
```

### 3) Universal flow (manual)
```swift
guard let oauth = swiki.oauth else { fatalError("OAuth is not configured") }
let url = try oauth.authorizationURL(scopes: [.userRates, .comments])
// Open url in a browser and get `code` from your redirect URI
let token = try await oauth.exchangeCode("<authorization_code>")
```

### 4) Token refresh
- Automatically:
  - on `401`, the request is retried after `refreshTokenIfPossible()`;
  - when a token expires, `validAccessToken()` attempts refresh.
- Manually:
```swift
let newToken = try await swiki.oauth?.refreshToken()
```

### 5) Token storage
- Apple platforms: `SwikiKeychainOAuthTokenStore` is used by default.
- Other platforms: provide your own `SwikiOAuthTokenStore` implementation.

```swift
public struct CustomTokenStore: SwikiOAuthTokenStore {
    public init() {}

    public func loadToken() async throws -> SwikiOAuthToken? {
        nil
    }

    public func saveToken(_ token: SwikiOAuthToken?) async throws {
        // persist token
    }
}
```

## REST API
### Structure
```swift
swiki.v1.<resource>
swiki.v2.<resource>
```

### Basic subclient methods
Most subclients expose:
- `list(query:)` for collection endpoints with filters/pagination.
- `get(id:)`
- `create(body:)`
- `update(id:body:method:)`
- `delete(id:)`
- resource-specific methods (for example `roles(id:)`, `whoami()`, `increment(id:)`).
- `query` parameters are available only on endpoints where Shikimori API supports them.
- `request(...)` for arbitrary methods/actions.

### Typed Queries (v1/v2)
For endpoints that accept query parameters, `v1/v2` clients use concrete typed query models from `Sources/Swiki/Queries`:
- typed query models (`SwikiV1AnimesQuery`, `SwikiV1UsersQuery`, `SwikiV1UserRatesQuery`, `SwikiV1TopicsQuery`, `SwikiV1CommentsQuery`, `SwikiV2UserRatesQuery`, etc.).
- `SwikiQuery` is still used only for endpoints with free-form query payloads.

```swift
let animes = try await swiki.v1.animes.get(
    query: SwikiV1AnimesQuery(
        page: 1,
        limit: 5,
        order: .ranked,
        status: .released,
        search: "bakemonogatari"
    )
)

let rates = try await swiki.v2.userRates.get(
    query: SwikiV2UserRatesQuery(
        page: 1,
        limit: 20,
        userID: "123",
        targetType: .anime,
        status: .watching
    )
)
```

### V1 resources
`achievements`, `animes`, `appears`, `bans`, `calendars`, `characters`, `clubs`, `collections`, `comments`, `constants`, `dialogs`, `favorites`, `forums`, `friends`, `genres`, `ignores`, `mangas`, `messages`, `people`, `publishers`, `ranobe`, `reviews`, `stats`, `studios`, `styles`, `topicIgnores`, `topics`, `userImages`, `userRates`, `userRatesLogs`, `users`, `videos`, `whoami`.

### V2 resources
`abuseRequests`, `episodeNotifications`, `topicIgnore`, `userIgnore`, `userRates`.

### REST examples
```swift
// v1 users
let user = try await swiki.v1.users.get(id: "1")
let whoami = try await swiki.v1.whoami.get()

// v1 animes custom action
let roles = try await swiki.v1.animes.roles(id: "1")

// v2 user rates
let rate = try await swiki.v2.userRates.get(id: "100")
let updated = try await swiki.v2.userRates.increment(id: "100")
```

## GraphQL API
### 1) Raw GraphQL
```swift
import Swiki
import SwikiModels

struct SearchVars: Encodable {
    let search: String?
    let limit: Int?
}

struct SearchResponse: Decodable {
    struct AnimeItem: Decodable {
        let id: String
        let name: String
    }
    let animes: [AnimeItem]
}

let response: SearchResponse = try await swiki.graphQL.execute(
    query: """
    query SearchAnimes($search: String, $limit: PositiveInt) {
      animes(search: $search, limit: $limit) { id name }
    }
    """,
    operationName: "SearchAnimes",
    variables: SearchVars(search: "bakemonogatari", limit: 3),
    responseType: SearchResponse.self
)
```

### 2) Typed operations
```swift
import Swiki
import SwikiModels

let operation = SwikiGraphQLOperations.DefaultUserRatesOperation(
    variables: .init(
        page: 1,
        limit: 5,
        userId: nil,
        targetType: .anime,
        status: nil,
        orderField: .updatedAt,
        sortOrder: .desc
    )
)

let data = try await swiki.graphQL.execute(operation: operation)
print(data.userRates.count)
```

## GraphQL Operation Generation
Operations are stored in `GraphQLOperations/*.graphql`.

Generate with:
```bash
swift run SwikiGraphQLOperationGenerator \
  --schema Sources/SwikiModels/schema.graphql \
  --operations GraphQLOperations \
  --output Sources/SwikiModels/GraphQL
```

After generation:
- `Sources/SwikiModels/GraphQL/SwikiGraphQLOperations.generated.swift` (namespace)
- `Sources/SwikiModels/GraphQL/SwikiGraphQLOperations+<OperationName>.generated.swift` (one file per operation)

Current default operations:
- `DefaultAnimesOperation`
- `DefaultMangasOperation`
- `DefaultCharactersOperation`
- `DefaultPeopleOperation`
- `DefaultUserRatesOperation`

## Model Typing
- All REST models are in `SwikiModels`.
- GraphQL generator is configured to reuse parts of `SwikiModels`:
  - enum types (`SwikiAnimeKind`, `SwikiUserRateStatus`, etc.),
  - `SwikiIncompleteDate` for `IncompleteDate`.

## Limits and Headers
- Built-in request limiter by default: `5 RPS` and `90 RPM` (can be disabled with `isRpsRpmRestrictionsEnabled: false`).
- Added headers:
  - `User-Agent` (from configuration),
  - `Authorization: Bearer ...` (if token is available),
  - `X-Client-Id` (if `clientId`/`oauthCredentials.clientId` is set),
  - any `additionalHeaders`.

## Errors
- REST/GraphQL transport: `SwikiClientError`
- OAuth: `SwikiOAuthError`
- Keychain store: `SwikiKeychainOAuthTokenStoreError`

## Project Structure
- `Sources/Swiki` - clients, transport, OAuth, configuration
- `Sources/SwikiModels` - REST/GraphQL models
- `Sources/SwikiGraphQLOperationGenerator` - GraphQL operation generator CLI
- `GraphQLOperations` - source `.graphql` operations
- `Tests/SwikiTests` - tests

## Useful Commands
```bash
swift build
swift test
swift run SwikiGraphQLOperationGenerator --help
```

## Example SwiftUI Project
A ready-to-run example app is available in:
- `Examples/SwikiExampleApp`

What the example demonstrates:
- OAuth authorization (`ASWebAuthenticationSession`)
- REST requests (`v1/users/whoami`, `v1/animes`)
- Typed GraphQL operation

Detailed run instructions:
- `Examples/SwikiExampleApp/README.md`

## License
MIT. See `LICENSE`.
