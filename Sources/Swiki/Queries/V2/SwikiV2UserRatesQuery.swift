import Foundation
import SwikiModels

public struct SwikiV2UserRatesQuery: SwikiQueryConvertible {
    /// Must be a number between 1 and 100000.
    /// - Note: This field is ignored when user_id is set
    public var page: Limit_100_000?
    /// 1000 maximum.
    /// - Note: This field is ignored when user_id is set
    public var limit: Limit_100?
    public var userId: String?
    public var targetId: String?
    public var targetType: SwikiUserRateTargetType?
    public var status: SwikiUserRateStatus?
    public var extra: SwikiQuery

    public init(
        page: Limit_100_000? = nil,
        limit: Limit_100? = nil,
        userId: String? = nil,
        targetId: String? = nil,
        targetType: SwikiUserRateTargetType? = nil,
        status: SwikiUserRateStatus? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.userId = userId
        self.targetId = targetId
        self.targetType = targetType
        self.status = status
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page?.rawValue.description,
            "limit": limit?.rawValue.description,
            "user_id": userId,
            "target_id": targetId,
            "target_type": targetType?.rawValue,
            "status": status?.rawValue
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
