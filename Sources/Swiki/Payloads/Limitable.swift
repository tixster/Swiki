import Foundation

public protocol Limitable: RawRepresentable<Int>, ExpressibleByIntegerLiteral, Sendable {
    init(integerLiteral value: IntegerLiteralType)
}
