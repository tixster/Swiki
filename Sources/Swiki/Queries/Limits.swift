import Foundation

public protocol IntBounds: Sendable {
    static var lower: Int { get }
    static var upper: Int { get }
}

public struct BoundedInt<B: IntBounds>: RawRepresentable, ExpressibleByIntegerLiteral, Sendable {

    public typealias RawValue = Int
    public let rawValue: Int

    @inline(__always)
    private static func clamp(_ value: Int) -> Int {
        min(max(value, B.lower), B.upper)
    }

    public init(rawValue: Int) {
        self.rawValue = Self.clamp(rawValue)
    }

    public init(clamping value: Int) {
        self.init(rawValue: value)
    }

    public init?(validating value: Int) {
        guard (B.lower...B.upper).contains(value) else { return nil }
        self.rawValue = value
    }

    public init(_ value: Int) {
        self.init(rawValue: value)
    }

    public init(integerLiteral value: Int) {
        self.init(rawValue: value)
    }
}

public enum Limits {

    public enum _10: IntBounds {
        public static let lower = 1
        public static let upper = 10
    }

    public enum _30: IntBounds {
        public static let lower = 1
        public static let upper = 30
    }

    public enum _50: IntBounds {
        public static let lower = 1
        public static let upper = 50
    }

    public enum _100: IntBounds {
        public static let lower = 1
        public static let upper = 100
    }

    public enum _1000: IntBounds {
        public static let lower = 1
        public static let upper = 1000
    }


    public enum _5_000: IntBounds {
        public static let lower = 1
        public static let upper = 5_000
    }

    public enum _100_000: IntBounds {
        public static let lower = 1
        public static let upper = 100_000
    }

}


public typealias Limit_10 = BoundedInt<Limits._10>
public typealias Limit_30 = BoundedInt<Limits._30>
public typealias Limit_50 = BoundedInt<Limits._50>
public typealias Limit_100 = BoundedInt<Limits._100>
public typealias Limit_5_000 = BoundedInt<Limits._5_000>
public typealias Limit_100_000 = BoundedInt<Limits._100_000>

