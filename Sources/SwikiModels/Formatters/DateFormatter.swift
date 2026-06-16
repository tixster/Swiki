import Foundation

extension DateFormatter {

    public static let yyyyMMdd: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

}

extension ISO8601DateFormatter {

    public static let fractional: SendableISO8601Formatter = {
        let fractional = SendableISO8601Formatter(formatOptions: [.withInternetDateTime, .withFractionalSeconds])
        return fractional
    }()

    public static let basic: SendableISO8601Formatter = {
        let fractional = SendableISO8601Formatter(formatOptions: [.withInternetDateTime])
        return fractional
    }()

}


public final class SendableISO8601Formatter: @unchecked Sendable {

    private let lock = NSLock()
    private let formatter: ISO8601DateFormatter

    public init(formatOptions: ISO8601DateFormatter.Options) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = formatOptions
        self.formatter = formatter
    }

    public func date(from string: String) -> Date? {
        lock.withLock { formatter.date(from: string) }
    }

}
