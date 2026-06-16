import Foundation

extension DateFormatter {

    public static let yyyyMMdd: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

}

extension ISO8601DateFormatter {

    public static let fractional: ISO8601DateFormatter = {
        let fractional = ISO8601DateFormatter()
        fractional.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return fractional
    }()

    public static let basic: ISO8601DateFormatter = {
        let fractional = ISO8601DateFormatter()
        fractional.formatOptions = [.withInternetDateTime]
        return fractional
    }()

}

extension ISO8601DateFormatter: @unchecked @retroactive Sendable {}
