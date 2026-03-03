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
    func get(query: SwikiV1PeopleQuery) async throws -> [SwikiPerson] { try await list(query: query.asSwikiQuery) }
    func get(id: String) async throws -> SwikiPerson { try await resourceClient.get(id: id) }
}
