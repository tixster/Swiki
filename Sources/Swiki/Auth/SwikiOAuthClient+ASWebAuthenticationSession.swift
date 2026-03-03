#if canImport(AuthenticationServices) && (os(iOS) || os(macOS) || os(visionOS))
@preconcurrency import AuthenticationServices
import Foundation
#if os(macOS)
import AppKit
#endif

public extension SwikiOAuthClient {
    func authorizeWithWebAuthenticationSession(
        scopes: [SwikiOAuthScope],
        prefersEphemeralWebBrowserSession: Bool = false,
        presentationAnchor: ASPresentationAnchor? = nil
    ) async throws -> SwikiOAuthToken {
        let authorizeURL = try authorizationURL(scopes: scopes)
        let callbackScheme = URL(string: credentials.redirectURI)?.scheme

        let callbackURL = try await SwikiOAuthWebAuthenticationSessionRunner.run(
            authorizeURL: authorizeURL,
            callbackScheme: callbackScheme,
            prefersEphemeralWebBrowserSession: prefersEphemeralWebBrowserSession,
            presentationAnchor: presentationAnchor
        )

        let code = try Self.extractAuthorizationCode(from: callbackURL)
        return try await exchangeCode(code)
    }

    private static func extractAuthorizationCode(from callbackURL: URL) throws -> String {
        guard let components = URLComponents(url: callbackURL, resolvingAgainstBaseURL: false) else {
            throw SwikiOAuthError.missingAuthorizationCode
        }

        if let error = components.queryItems?.first(where: { $0.name == "error" })?.value {
            throw SwikiOAuthError.invalidRedirectURL(error)
        }

        guard let code = components.queryItems?.first(where: { $0.name == "code" })?.value, !code.isEmpty else {
            throw SwikiOAuthError.missingAuthorizationCode
        }

        return code
    }
}

@MainActor
private enum SwikiOAuthWebAuthenticationSessionRunner {
    static func run(
        authorizeURL: URL,
        callbackScheme: String?,
        prefersEphemeralWebBrowserSession: Bool,
        presentationAnchor: ASPresentationAnchor?
    ) async throws -> URL {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<URL, Error>) in
            let contextProvider = SwikiOAuthPresentationContextProvider(anchor: presentationAnchor)
            var session: ASWebAuthenticationSession?
            session = ASWebAuthenticationSession(
                url: authorizeURL,
                callbackURLScheme: callbackScheme
            ) { callbackURL, error in
                if let session {
                    SwikiOAuthSessionRetainer.shared.release(session: session)
                }

                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let callbackURL else {
                    continuation.resume(throwing: SwikiOAuthError.invalidResponse)
                    return
                }

                continuation.resume(returning: callbackURL)
            }

            session?.prefersEphemeralWebBrowserSession = prefersEphemeralWebBrowserSession
            session?.presentationContextProvider = contextProvider

            if let session {
                SwikiOAuthSessionRetainer.shared.retain(session: session, provider: contextProvider)
                if !session.start() {
                    SwikiOAuthSessionRetainer.shared.release(session: session)
                    continuation.resume(throwing: SwikiOAuthError.invalidResponse)
                }
            } else {
                continuation.resume(throwing: SwikiOAuthError.invalidResponse)
            }
        }
    }
}

@MainActor
private final class SwikiOAuthPresentationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    private let anchor: ASPresentationAnchor?

    init(anchor: ASPresentationAnchor?) {
        self.anchor = anchor
    }

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        #if os(macOS)
        if let anchor {
            return anchor
        }
        return NSApplication.shared.windows.first ?? ASPresentationAnchor()
        #else
        if let anchor {
            return anchor
        }
        return ASPresentationAnchor()
        #endif
    }
}

@MainActor
private final class SwikiOAuthSessionRetainer {
    static let shared = SwikiOAuthSessionRetainer()

    private var sessions: [ObjectIdentifier: (session: ASWebAuthenticationSession, provider: SwikiOAuthPresentationContextProvider)] = [:]

    func retain(
        session: ASWebAuthenticationSession,
        provider: SwikiOAuthPresentationContextProvider
    ) {
        sessions[ObjectIdentifier(session)] = (session, provider)
    }

    func release(session: ASWebAuthenticationSession) {
        sessions.removeValue(forKey: ObjectIdentifier(session))
    }
}
#endif
