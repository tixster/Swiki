//
//  SwikiStylePreviewPayloadBody.swift
//  Swiki
//
//  Created by Кирилл Тила on 04.03.2026.
//


import Foundation

struct SwikiStylePreviewPayloadBody: Encodable, Sendable {
    public let style: SwikiStylePreviewPayload
}

public struct SwikiStylePreviewPayload: Encodable, Sendable {
    public let css: String
    public init(css: String) {
        self.css = css
    }
}