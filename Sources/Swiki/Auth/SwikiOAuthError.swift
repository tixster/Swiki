import Foundation

public enum SwikiOAuthError: Error, LocalizedError, Sendable {
    case invalidAuthorizeURL
    case invalidTokenURL
    case invalidRedirectURL(String)
    case missingAuthorizationCode
    case missingRefreshToken
    case invalidResponse
    case badStatusCode(Int, String?)

    public var errorDescription: String? {
        switch self {
        case .invalidAuthorizeURL:
            "Cannot build OAuth authorize URL"
        case .invalidTokenURL:
            "Cannot build OAuth token URL"
        case let .invalidRedirectURL(value):
            "Invalid OAuth redirect URL: \(value)"
        case .missingAuthorizationCode:
            "OAuth callback URL does not contain authorization code"
        case .missingRefreshToken:
            "Refresh token is missing"
        case .invalidResponse:
            "Invalid OAuth response"
        case let .badStatusCode(statusCode, body):
            if let body, !body.isEmpty {
                "OAuth request failed with HTTP \(statusCode): \(body)"
            } else {
                "OAuth request failed with HTTP \(statusCode)"
            }
        }
    }
}

