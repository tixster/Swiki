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

    /// GET ``/api/people/:id``
    ///
    /// Show a person.
    func person(id: String) async throws -> SwikiPerson {
        try await resourceClient.get(id: id)
    }

    /// GET ``/api/people/search ``
    ///
    /// Search people
    func search(query: SwikiV1PeopleQuery) async throws -> [SwikiPersonPreview] {
        try await request(.get, route: "search", query: query.asSwikiQuery)
    }

}
