import Foundation

/**
 Клиент Shikimori API.

 Использование:
 - `swiki.v1.<resource>` для методов API v1
 - `swiki.v2.<resource>` для методов API v2
 */
public final class Swiki: Sendable {
    public let v1: SwikiV1Client
    public let v2: SwikiV2Client

    public init(
        configuration: SwikiConfiguration,
        session: URLSession = .shared
    ) {
        let transport = SwikiHTTPTransport(configuration: configuration, session: session)
        self.v1 = SwikiV1Client(transport: transport)
        self.v2 = SwikiV2Client(transport: transport)
    }
}
