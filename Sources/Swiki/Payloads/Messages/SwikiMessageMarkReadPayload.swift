//
//  SwikiMessageDeleteAllPayload.swift
//  Swiki
//
//  Created by Кирилл Тила on 04.03.2026.
//


import Foundation
import SwikiModels

public struct SwikiMessageDeleteAllPayload: Encodable, Sendable {
    public let type: SwikiMessageType

    public init(type: SwikiMessageType) {
        self.type = type
    }

}
