import Foundation
import SwikiModels

public struct SwikiV1UserRatesQuery: SwikiQueryConvertible {
    public let page: Int?
    public let limit: Int?
    public let userID: String?
    public let targetID: String?
    public let targetType: SwikiUserRateTargetType?
    public let status: SwikiUserRateStatus?
    public let extra: SwikiQuery

    public init(
        page: Int? = nil,
        limit: Int? = nil,
        userID: String? = nil,
        targetID: String? = nil,
        targetType: SwikiUserRateTargetType? = nil,
        status: SwikiUserRateStatus? = nil,
        extra: SwikiQuery = [:]
    ) {
        self.page = page
        self.limit = limit
        self.userID = userID
        self.targetID = targetID
        self.targetType = targetType
        self.status = status
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "page": page.map(String.init),
            "limit": limit.map(String.init),
            "user_id": userID,
            "target_id": targetID,
            "target_type": targetType?.rawValue,
            "status": status?.rawValue
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
