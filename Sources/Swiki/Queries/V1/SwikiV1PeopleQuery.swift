import Foundation

public struct SwikiV1PeopleQuery: SwikiQueryConvertible {
    public enum Kind: String, Sendable {
        case seyu
        case mangaka
        case producer
    }

    public let search: String?
    public let kind: Kind?
    public let extra: SwikiQuery

    public init(search: String? = nil, kind: Kind? = nil, extra: SwikiQuery = [:]) {
        self.search = search
        self.kind = kind
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "search": search,
            "kind": kind?.rawValue
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
