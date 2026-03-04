import Foundation

public struct SwikiV1AchievementsQuery: SwikiQueryConvertible {
    /// Must be a number.
    public var userId: String
    public var extra: SwikiQuery

    /// GET /api/achievements
    /// - Parameters:
    ///   - userId: Must be a number.
    public init(userId: String, extra: SwikiQuery = [:]) {
        self.userId = userId
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        SwikiQueryEncoding.merge(["user_id": userId], with: extra)
    }

}
