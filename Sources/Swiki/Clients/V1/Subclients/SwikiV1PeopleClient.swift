import Foundation
import SwikiModels

public struct SwikiV1PeopleClient: SwikiResourceSubclient {
    public typealias Model = SwikiPerson
    public let resourceClient: SwikiResourceClient<SwikiPerson>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "people")
    }
}

public extension SwikiV1PeopleClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiPerson] { try await list(query: query) }
    func get(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> SwikiPerson { try await resourceClient.get(id: id, query: query) }
}
