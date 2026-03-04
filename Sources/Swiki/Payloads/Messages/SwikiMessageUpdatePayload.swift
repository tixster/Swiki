//
//  SwikiMessageCreatePayload 2.swift
//  Swiki
//
//  Created by Кирилл Тила on 04.03.2026.
//


public struct SwikiMessageCreatePayload: Encodable, Sendable {
    public let body: String
    public let fromId: String
    public let kind: SwikiMessageKind
    public let toId: String

    enum CodingKeys: String, CodingKey {
        case body
        case fromId = "from_id"
        case kind
        case toId = "to_id"
    }

    public init(
        body: String,
        fromId: String,
        kind: SwikiMessageKind,
        toId: String
    ) {
        self.body = body
        self.fromId = fromId
        self.kind = kind
        self.toId = toId
    }

}