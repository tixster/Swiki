import Foundation
import SwikiModels

public struct SwikiV1HistoryQuery: SwikiQueryConvertible {
    /// Must be a number between 1 and 100000.
    public var page: Int?
    /// 100 maximum
    public var limit: Int?
    public var targetId: String?
    public var targetType: SwikiUserRateTargetType?
    public var extra: SwikiQuery

    public init(
        page: Int? = nil,
        limit: Int? = nil,
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
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "target_id": targetId,
            "target_type": targetType?.rawValue
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
