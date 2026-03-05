#if canImport(Security) && (os(iOS) || os(macOS) || os(tvOS) || os(watchOS) || os(visionOS))
import Foundation
import Security

public struct SwikiKeychainOAuthTokenStore: SwikiOAuthTokenStore {
    public let service: String
    public let account: String

    public init(
        service: String = Bundle.main.bundleIdentifier ?? "Swiki",
        account: String = "oauth.token"
    ) {
        self.service = service
        self.account = account
    }

    public func loadToken() async throws -> SwikiOAuthToken? {
        var query = baseQuery()
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status == errSecItemNotFound {
            return nil
        }

        guard status == errSecSuccess else {
            throw SwikiKeychainOAuthTokenStoreError.keychain(status)
        }

        guard let data = item as? Data else {
            return nil
        }

        do {
            return try JSONDecoder().decode(SwikiOAuthToken.self, from: data)
        } catch {
            throw SwikiKeychainOAuthTokenStoreError.decoding(error)
        }
    }

    public func saveToken(_ token: SwikiOAuthToken?) async throws {
        if token == nil {
            let status = SecItemDelete(baseQuery() as CFDictionary)
            guard status == errSecSuccess || status == errSecItemNotFound else {
                throw SwikiKeychainOAuthTokenStoreError.keychain(status)
            }
            return
        }

        let data: Data
        do {
            data = try JSONEncoder().encode(token)
        } catch {
            throw SwikiKeychainOAuthTokenStoreError.encoding(error)
        }

        var query = baseQuery()
        query[kSecValueData as String] = data

        let addStatus = SecItemAdd(query as CFDictionary, nil)
        if addStatus == errSecSuccess {
            return
        }

        guard addStatus == errSecDuplicateItem else {
            throw SwikiKeychainOAuthTokenStoreError.keychain(addStatus)
        }

        let attributesToUpdate: [String: Any] = [kSecValueData as String: data]
        let updateStatus = SecItemUpdate(baseQuery() as CFDictionary, attributesToUpdate as CFDictionary)
        guard updateStatus == errSecSuccess else {
            throw SwikiKeychainOAuthTokenStoreError.keychain(updateStatus)
        }
    }

    private func baseQuery() -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
    }
}

public enum SwikiKeychainOAuthTokenStoreError: Error, LocalizedError, Sendable {
    case keychain(OSStatus)
    case encoding(any Error)
    case decoding(any Error)

    public var errorDescription: String? {
        switch self {
        case let .keychain(status):
            "Keychain operation failed with status: \(status)"
        case let .encoding(error):
            "Cannot encode OAuth token for keychain: \(error.localizedDescription)"
        case let .decoding(error):
            "Cannot decode OAuth token from keychain: \(error.localizedDescription)"
        }
    }
}
#endif

