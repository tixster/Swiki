import Foundation
import SwikiModels

public struct SwikiV2UserRatesQuery: SwikiQueryConvertible {
    public var page: Int?
    public var limit: Int?
    public var userId: String?
    public var targetId: String?
    public var targetType: SwikiUserRateTargetType?
    public var status: SwikiUserRateStatus?
    public var extra: SwikiQuery

    public init(
        page: Int? = nil,
        limit: Int? = nil,
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
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "user_id": userId,
            "target_id": targetId,
            "target_type": targetType?.rawValue,
            "status": status?.rawValue
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
