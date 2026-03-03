import Foundation
import SwikiModels

public struct SwikiV1DialogsClient: SwikiResourceSubclient {
    public typealias Model = SwikiDialog
    public let resourceClient: SwikiResourceClient<SwikiDialog>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "dialogs")
    }
}

public extension SwikiV1DialogsClient {
    func get(query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiDialog] { try await list(query: query) }
    func messages(fromNickname: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws -> [SwikiMessage] {
        try await request(.get, id: fromNickname, query: query)
    }
    func delete(nickname: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await request(.delete, id: nickname, query: query)
    }
}
