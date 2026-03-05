import Foundation
import SwikiModels

public struct SwikiV1HistoryQuery: SwikiQueryConvertible {
    /// Must be a number between 1 and 100000.
    public var page: Limit_100_000?
    /// 100 maximum
    public var limit: Limit_100?
    public var targetId: String?
    public var targetType: SwikiUserRateTargetType?
    public var extra: SwikiQuery

    public init(
        page: Limit_100_000? = nil,
        limit: Limit_100? = nil,
        targetId: String? = nil,
        targetType: SwikiUserRateTargetType? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.targetId = targetId
        self.targetType = targetType
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page?.rawValue.description,
            "limit": limit?.rawValue.description,
            "target_id": targetId,
            "target_type": targetType?.rawValue
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
