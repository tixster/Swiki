import Foundation

public struct SwikiV1AchievementsQuery: SwikiQueryConvertible {
    public let userID: Int
    public let extra: SwikiQuery

    public init(userID: Int, extra: SwikiQuery = [:]) {
        self.userID = userID
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        SwikiQueryEncoding.merge(["user_id": String(userID)], with: extra)
    }
}
