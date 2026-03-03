import Foundation

public enum SwikiQueryFilter<Value>: Sendable where Value: RawRepresentable & Sendable, Value.RawValue == String {
    case include(Value)
    case exclude(Value)

    var queryToken: String {
        switch self {
        case let .include(value):
            return value.rawValue
        case let .exclude(value):
            return "!\(value.rawValue)"
        }
    }
}
