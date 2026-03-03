import Foundation

public struct SwikiV1CharactersQuery: SwikiQueryConvertible {
    public let search: String
    public let extra: SwikiQuery

    public init(search: String, extra: SwikiQuery = [:]) {
        self.search = search
        self.extra = extra
    }

    public var asSwikiQuery: SwikiQuery {
        SwikiQueryEncoding.merge(["search": search], with: extra)
    }
}
