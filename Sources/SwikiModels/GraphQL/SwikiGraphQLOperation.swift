import Foundation

public struct SwikiGraphQLEmptyVariables: Codable, Sendable {
    public init() {}
}

public protocol SwikiGraphQLOperation: Sendable {
    associatedtype Variables: Encodable & Sendable
    associatedtype Data: Decodable & Sendable

    static var operationName: String? { get }
    static var operationDocument: String { get }

    var variables: Variables { get }
}
