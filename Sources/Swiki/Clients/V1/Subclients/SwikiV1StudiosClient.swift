import Foundation
import SwikiModels

public struct SwikiV1StudiosClient: SwikiResourceSubclient {
    public typealias Model = SwikiStudio
    public let resourceClient: SwikiResourceClient<SwikiStudio>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "studios")
    }
}

public extension SwikiV1StudiosClient {
    /// GET ``/api/studios``
    ///
    /// List studios.
    func list() async throws -> [SwikiStudio] {
        try await resourceClient.list()
    }
}
