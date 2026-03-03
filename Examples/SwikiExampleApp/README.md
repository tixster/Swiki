# SwikiExampleApp
Отдельный пример iOS SwiftUI-приложения для `Swiki`:
- OAuth авторизация через `ASWebAuthenticationSession`
- REST запросы (`v1/users/whoami`, `v1/animes`)
- GraphQL типизированная операция (`DefaultUserRatesOperation`)

## Что внутри
- `Project.swift` — Tuist-манифест проекта
- `Sources/SwikiExampleApp.swift` — entry point приложения
- `Sources/ContentView.swift` — UI экрана
- `Sources/ExampleAppViewModel.swift` — логика авторизации и запросов

## Запуск
1. Установите [Tuist](https://tuist.dev/).
2. Из корня репозитория выполните:
   ```bash
   tuist generate --path Examples/SwikiExampleApp
   ```
3. Откройте сгенерированный workspace и запустите `SwikiExampleApp` на iOS Simulator.

## Настройка OAuth
В приложении заполните поля:
- `Client ID`
- `Client Secret`
- `Redirect URI` (по умолчанию `swikiexample://oauth/callback`)
- `User-Agent`

Важно:
- В настройках OAuth приложения на Shikimori redirect URI должен совпадать 1-в-1.
- Схема `swikiexample` уже добавлена в `Info.plist` через `Project.swift`.
