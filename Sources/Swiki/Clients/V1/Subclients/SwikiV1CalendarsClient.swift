import Foundation
import SwikiModels

/// /api/calendar
public struct SwikiV1CalendarsClient: SwikiResourceSubclient {
    public typealias Model = SwikiCalendar
    public let resourceClient: SwikiResourceClient<SwikiCalendar>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "calendars")
    }
}

public extension SwikiV1CalendarsClient {

    /// GET ``/api/calendar``
    ///
    /// Show a calendar
    func list(query: SwikiQuery = [:]) async throws -> [SwikiCalendar] {
        try await resourceClient.list(query: query)
    }

}
