import Foundation

public struct SwikiV2EpisodeNotificationsQuery: SwikiQueryConvertible {
    public var token: String
    public var extra: SwikiQuery

    public init(token: String, extra: SwikiQuery = [:]) {
        self.token = token
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        let query: SwikiQuery = [
            "token": token
        ]
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
