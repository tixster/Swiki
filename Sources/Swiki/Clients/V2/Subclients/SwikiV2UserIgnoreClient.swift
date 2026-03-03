import Foundation
import SwikiModels

public struct SwikiV2UserIgnoreClient: SwikiResourceSubclient {
    public typealias Model = SwikiUserIgnore
    public let resourceClient: SwikiResourceClient<SwikiUserIgnore>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "user_ignore")
    }
}

public extension SwikiV2UserIgnoreClient {
    func create(userId: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.post, id: userId, query: query)
    }

    func delete(userId: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.delete, id: userId, query: query)
    }
}
