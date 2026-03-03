import Foundation

public struct SwikiV1CharactersQuery: SwikiQueryConvertible {
    public let search: String?
    public let extra: SwikiQuery

    public init(search: String? = nil, extra: SwikiQuery = [:]) {
        self.search = search
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        var query: SwikiQuery = [
            "search": search
        ]
        query = query.filter { $0.value != nil }
        return SwikiQueryEncoding.merge(query, with: extra)
    }
}
