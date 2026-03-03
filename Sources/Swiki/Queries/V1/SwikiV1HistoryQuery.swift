import Foundation
import SwikiModels

public struct SwikiV1HistoryQuery: SwikiQueryConvertible {
    public let page: Int?
    public let limit: Int?
    public let targetID: String?
    public let targetType: SwikiUserRateTargetType?
    public let updatedAtGTE: String?
    public let updatedAtLTE: String?
    public let extra: SwikiQuery

    public init(
        page: Int? = nil,
        limit: Int? = nil,
        targetID: String? = nil,
        targetType: SwikiUserRateTargetType? = nil,
        updatedAtGTE: String? = nil,
        updatedAtLTE: String? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.targetID = targetID
        self.targetType = targetType
        self.updatedAtGTE = updatedAtGTE
        self.updatedAtLTE = updatedAtLTE
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "target_id": targetID,
            "target_type": targetType?.rawValue,
            "updated_at_gte": updatedAtGTE,
            "updated_at_lte": updatedAtLTE
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
