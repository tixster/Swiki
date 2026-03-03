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
    func roles(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [[SwikiPersonRole]] {
        try await request(.get, id: id, action: "roles", query: query)
    }
    func works(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiPersonWork] {
        try await request(.get, id: id, action: "works", query: query)
    }
}
