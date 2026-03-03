import Foundation

public protocol SwikiOAuthTokenStore: Sendable {
    func loadToken() async throws -> SwikiOAuthToken?
    func saveToken(_ token: SwikiOAuthToken?) async throws
}

