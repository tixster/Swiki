import Foundation
import SwikiModels

public struct SwikiV1HistoryQuery: SwikiQueryConvertible {
    public var page: Int?
    public var limit: Int?
    public var targetId: String?
    public var targetType: SwikiUserRateTargetType?
    public var updatedAtGTE: String?
    public var updatedAtLTE: String?
    public var extra: SwikiQuery

    public init(
        page: Int? = nil,
        limit: Int? = nil,
        targetId: String? = nil,
        targetType: SwikiUserRateTargetType? = nil,
        updatedAtGTE: String? = nil,
        updatedAtLTE: String? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.targetId = targetId
        self.targetType = targetType
        self.updatedAtGTE = updatedAtGTE
        self.updatedAtLTE = updatedAtLTE
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "target_id": targetId,
            "target_type": targetType?.rawValue,
            "updated_at_gte": updatedAtGTE,
            "updated_at_lte": updatedAtLTE
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
