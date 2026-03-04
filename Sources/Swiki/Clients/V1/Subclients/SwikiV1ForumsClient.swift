import Foundation
import SwikiModels

/// ``/api/forums``
public struct SwikiV1ForumsClient: SwikiResourceSubclient {
    public typealias Model = SwikiForum
    public let resourceClient: SwikiResourceClient<SwikiForum>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v1, path: "forums")
    }
}

public extension SwikiV1ForumsClient {

    /// GET ``/api/forums``
    ///
    /// List of forums
    func list() async throws -> [SwikiForum] {
        try await resourceClient.list()
    }

}
