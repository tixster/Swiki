import Foundation
import SwikiModels

public struct SwikiV1HistoryQuery: SwikiQueryConvertible {
    public let page: Int?
    public let limit: Int?
    public let targetID: String?
    public let targetType: SwikiUserRateTargetType?
    public let extra: SwikiQuery

    public init(
        page: Int? = nil,
        limit: Int? = nil,
        targetID: String? = nil,
        targetType: SwikiUserRateTargetType? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.targetID = targetID
        self.targetType = targetType
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "target_id": targetID,
            "target_type": targetType?.rawValue
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
