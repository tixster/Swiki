import Foundation
import SwikiModels

public struct SwikiV1FavoritesClient: Sendable {
    public enum LinkedType: Sendable {
        public enum PersonKind: String, Sendable, CaseIterable {
            case common
            case seyu
            case mangaka
            case producer
            case person
        }
        case anime
        case manga
        case ranobe
        case person(kind: PersonKind)
        case character
        fileprivate var rawValue: String {
            switch self {
            case .anime:
                return "Anime"
            case .manga:
                return "Manga"
            case .ranobe:
                return "Ranobe"
            case .person:
                return "Person"
            case .character:
                return "Character"
            }
        }

        fileprivate var kindRawValue: String? {
            switch self {
            case let .person(kind):
                return kind.rawValue
            default:
                return nil
            }
        }
    }

    private let transport: SwikiHTTPTransport

    init(transport: SwikiHTTPTransport) {
        self.transport = transport
    }
}

public extension SwikiV1FavoritesClient {
    func create(
        linkedType: LinkedType,
        linkedId: String,
        query: some SwikiQueryConvertible = [:] as SwikiQuery
    ) async throws -> SwikiNoticeResponse {
        let action = [linkedId, linkedType.kindRawValue].compactMap { value in
            guard let value, !value.isEmpty else { return nil }
            return value
        }.joined(separator: "/")
        return try await transport.request(
            version: .v1,
            method: .post,
            path: "favorites",
            id: linkedType.rawValue,
            action: action,
            query: query
        )
    }

    func delete(
        linkedType: LinkedType,
        linkedId: String,
        query: some SwikiQueryConvertible = [:] as SwikiQuery
    ) async throws -> SwikiNoticeResponse {
        try await transport.request(
            version: .v1,
            method: .delete,
            path: "favorites",
            id: linkedType.rawValue,
            action: linkedId,
            query: query
        )
    }

    func reorder(id: String, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await transport.request(version: .v1, method: .post, path: "favorites", id: id, action: "reorder", query: query)
    }

    func reorder<Body: Encodable>(id: String, body: Body, query: some SwikiQueryConvertible = [:] as SwikiQuery) async throws {
        try await transport.request(
            version: .v1,
            method: .post,
            path: "favorites",
            id: id,
            action: "reorder",
            query: query,
            body: body
        )
    }
}
