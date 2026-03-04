# Swiki
Типизированный Swift-клиент для Shikimori API (`v1`, `v2`, `GraphQL`) с поддержкой OAuth2, авто-refresh токена и генерацией GraphQL операций.

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

## Возможности
- Разделение клиентов по версиям API: `swiki.v1`, `swiki.v2`, `swiki.graphQL`.
- Отдельные саб-клиенты на каждый ресурс (`users`, `animes`, `userRates`, `topicIgnore` и т.д.).
- Единый CRUD-интерфейс (`list`, `get`, `create`, `update`, `delete`) + ресурсные методы.
- OAuth2:
  - обмен `authorization_code` на токен,
  - refresh токена вручную и автоматически,
  - `ASWebAuthenticationSession` для Apple платформ.
- Хранилище токенов через `SwikiOAuthTokenStore`:
  - дефолтно Keychain на Apple-платформах,
  - кастомное хранилище для остальных платформ.
- GraphQL:
  - raw запросы,
  - типизированные операции (`SwikiGraphQLOperation`),
  - генерация операций из `.graphql` файлов (каждая операция в отдельный `.swift` файл).

## Требования
- Swift `6.2+`
- Платформы:
  - iOS 16+
  - macOS 13+
  - tvOS 16+
  - watchOS 9+
  - Linux

## Установка (Swift Package Manager)
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

Если нужны только модели:
```swift
.product(name: "SwikiModels", package: "Swiki")
```

## Быстрый старт
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

## Конфигурация
`SwikiConfiguration`:
- `userAgent` (обязателен)
- `clientId` / `accessToken` (статическая авторизация)
- `oauthCredentials` + `oauthTokenStore` (OAuth2)
- `oauthBaseURL` (по умолчанию `https://shikimori.io`)
- `graphQLURL` (по умолчанию `https://shikimori.io/api/graphql`)
- `baseURL` (по умолчанию `https://shikimori.io/api`)
- `apiLogger` (`swift-log` `Logger` для логирования API запросов)
- `additionalHeaders`
- `isRpsRpmRestrictionsEnabled` (`true` по умолчанию)

### Логирование API (`swift-log`)
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

В логах добавляются метаданные запроса: `kind`, `method`, `url`, `attempt`, `status`, `duration_ms`, размер request/response body и текст ошибки.

## OAuth2
### 1) Инициализация
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

### 2) Apple платформы: `ASWebAuthenticationSession`
```swift
#if canImport(AuthenticationServices)
let token = try await swiki.oauth?.authorizeWithWebAuthenticationSession(
    scopes: [.userRates, .comments, .topics]
)
#endif
```

### 3) Универсальный flow (вручную)
```swift
guard let oauth = swiki.oauth else { fatalError("OAuth не настроен") }
let url = try oauth.authorizationURL(scopes: [.userRates, .comments])
// Открываете url в браузере, получаете `code` из redirect URI
let token = try await oauth.exchangeCode("<authorization_code>")
```

### 4) Refresh токена
- Автоматически:
  - при `401` запрос будет повторён после `refreshTokenIfPossible()`;
  - при истечении токена `validAccessToken()` попробует refresh.
- Вручную:
```swift
let newToken = try await swiki.oauth?.refreshToken()
```

### 5) Хранилище токенов
- Apple-платформы: по умолчанию используется `SwikiKeychainOAuthTokenStore`.
- Другие платформы: передайте свою реализацию `SwikiOAuthTokenStore`.

```swift
public struct CustomTokenStore: SwikiOAuthTokenStore {
    public init() {}

    public func loadToken() async throws -> SwikiOAuthToken? {
        nil
    }

    public func saveToken(_ token: SwikiOAuthToken?) async throws {
        // сохранить token
    }
}
```

## REST API
### Структура
```swift
swiki.v1.<resource>
swiki.v2.<resource>
```

### Базовые методы саб-клиента
Большинство саб-клиентов предоставляет:
- `list(query:)` для коллекций с фильтрацией/пагинацией.
- `get(id:)`
- `create(body:)`
- `update(id:body:method:)`
- `delete(id:)`
- ресурсные методы (например `roles(id:)`, `whoami()`, `increment(id:)`).
- `query` доступен только там, где это поддерживает Shikimori API.
- `request(...)` для произвольного метода/экшена.

### Типизированные Query (v1/v2)
Для эндпоинтов с query-параметрами `v1/v2` клиенты используют конкретные типизированные модели из `Sources/Swiki/Queries`:
- типизированные query-модели (`SwikiV1AnimesQuery`, `SwikiV1UsersQuery`, `SwikiV1UserRatesQuery`, `SwikiV1TopicsQuery`, `SwikiV1CommentsQuery`, `SwikiV2UserRatesQuery` и др.).
- `SwikiQuery` остаётся только для эндпоинтов со свободной query-структурой.

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

### V1 ресурсы
`achievements`, `animes`, `appears`, `bans`, `calendars`, `characters`, `clubs`, `collections`, `comments`, `constants`, `dialogs`, `favorites`, `forums`, `friends`, `genres`, `ignores`, `mangas`, `messages`, `people`, `publishers`, `ranobe`, `reviews`, `stats`, `studios`, `styles`, `topicIgnores`, `topics`, `userImages`, `userRates`, `userRatesLogs`, `users`, `videos`, `whoami`.

### V2 ресурсы
`abuseRequests`, `episodeNotifications`, `topicIgnore`, `userIgnore`, `userRates`.

### Примеры REST
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

### 2) Типизированные операции
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

## Генерация GraphQL операций
Операции хранятся в `GraphQLOperations/*.graphql`.

Генерация:
```bash
swift run SwikiGraphQLOperationGenerator \
  --schema Sources/SwikiModels/schema.graphql \
  --operations GraphQLOperations \
  --output Sources/SwikiModels/GraphQL
```

После генерации:
- `Sources/SwikiModels/GraphQL/SwikiGraphQLOperations.generated.swift` (namespace)
- `Sources/SwikiModels/GraphQL/SwikiGraphQLOperations+<OperationName>.generated.swift` (один файл на операцию)

Текущие дефолтные операции:
- `DefaultAnimesOperation`
- `DefaultMangasOperation`
- `DefaultCharactersOperation`
- `DefaultPeopleOperation`
- `DefaultUserRatesOperation`

## Типизация моделей
- Все REST модели находятся в `SwikiModels`.
- Для GraphQL в генераторе подключено переиспользование части `SwikiModels`:
  - enum-типы (`SwikiAnimeKind`, `SwikiUserRateStatus`, и т.д.),
  - `SwikiIncompleteDate` для `IncompleteDate`.

## Лимиты и заголовки
- Встроенный лимитер запросов по умолчанию: `5 RPS` и `90 RPM` (можно отключить `isRpsRpmRestrictionsEnabled: false`).
- Добавляются заголовки:
  - `User-Agent` (из конфигурации),
  - `Authorization: Bearer ...` (если есть токен),
  - `X-Client-Id` (если задан `clientId`/`oauthCredentials.clientId`),
  - любые `additionalHeaders`.

## Ошибки
- REST/GraphQL транспорт: `SwikiClientError`
- OAuth: `SwikiOAuthError`
- Keychain store: `SwikiKeychainOAuthTokenStoreError`

## Структура проекта
- `Sources/Swiki` — клиенты, транспорт, OAuth, конфигурация
- `Sources/SwikiModels` — модели REST/GraphQL
- `Sources/SwikiGraphQLOperationGenerator` — CLI генератор GraphQL операций
- `GraphQLOperations` — исходные `.graphql` операции
- `Tests/SwikiTests` — тесты

## Полезные команды
```bash
swift build
swift test
swift run SwikiGraphQLOperationGenerator --help
```

## Example SwiftUI Project
Готовый пример приложения находится в:
- `Examples/SwikiExampleApp`

Что показывает пример:
- OAuth авторизацию (`ASWebAuthenticationSession`)
- REST запросы (`v1/users/whoami`, `v1/animes`)
- GraphQL типизированную операцию

Подробная инструкция запуска:
- `Examples/SwikiExampleApp/README.md`

## Лицензия
MIT. См. файл `LICENSE`.
