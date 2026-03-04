import Foundation
import SwikiModels

struct SwikiVideosCreatePayloadBody: Encodable, Sendable {
    let video: SwikiVideosCreatePayload
}

public struct SwikiVideosCreatePayload: Encodable, Sendable {
    public let name: String
    public let kind: SwikiVideoKind
    public let url: URL

    /// - Parameters:
    ///   - name: String
    ///   - kind: SwikiVideoKind
    ///   - url: Supported hostings: youtube,youtube_shorts,rutube,rutube_shorts,vk,ok,
    ///   coub,vimeo, sibnet,yandex,streamable,smotret_anime,myvi,youmite,viuly,mediafile
    public init(
        name: String,
        kind: SwikiVideoKind,
        url: URL
    ) {
        self.name = name
        self.kind = kind
        self.url = url
    }

}

