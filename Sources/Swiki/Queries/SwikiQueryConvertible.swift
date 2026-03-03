import Foundation

public protocol SwikiQueryConvertible: Sendable {
    var asSwikiQuery: SwikiQuery { get }
}

extension Dictionary: SwikiQueryConvertible where Key == String, Value == String? {
    public var asSwikiQuery: SwikiQuery { self }
}

enum SwikiQueryEncoding {
    static func bool(_ value: Bool) -> String {
        value ? "true" : "false"
    }

    static func csv(_ values: [Int]) -> String? {
        guard !values.isEmpty else {
            return nil
        }
        return values.map(String.init).joined(separator: ",")
    }

    static func csv(_ values: [String]) -> String? {
        guard !values.isEmpty else {
            return nil
        }
        return values.joined(separator: ",")
    }

    static func merge(_ lhs: SwikiQuery, with rhs: SwikiQuery) -> SwikiQuery {
        var result = lhs
        for (key, value) in rhs {
            result[key] = value
        }
        return result
    }
}
