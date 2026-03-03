import Foundation
import SwikiModels

public struct SwikiV1CalendarsClient: SwikiResourceSubclient {
    public typealias Model = SwikiCalendar
    public let resourceClient: SwikiResourceClient<SwikiCalendar>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "calendars")
    }
}

public extension SwikiV1CalendarsClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiCalendar] { try await list(query: query) }
}
