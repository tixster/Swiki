import Foundation
import GraphQLGeneratorMacros

public struct SwikiUser: Decodable, Sendable {
    @graphQLResolver public let id: String
    @graphQLResolver public let nickname: String
    @graphQLResolver public let url: URL?
    @graphQLResolver public let avatarUrl: URL
    @graphQLResolver public let lastOnlineAt: Date
}
