import Foundation
import SwikiModels

public struct SwikiV2AbuseRequestsClient: SwikiResourceSubclient {
    public typealias Model = SwikiAbuseRequest
    public let resourceClient: SwikiResourceClient<SwikiAbuseRequest>

    init(transport: SwikiHTTPTransport) {
        self.resourceClient = SwikiResourceClient<Model>(transport: transport, version: .v2, path: "abuse_requests")
    }
}

public extension SwikiV2AbuseRequestsClient {
    func create<Body: Encodable>(body: Body, query: SwikiQuery = [:]) async throws -> SwikiAbuseRequest {
        try await resourceClient.create(body: body, query: query)
    }
}
