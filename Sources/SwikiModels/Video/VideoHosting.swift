import Foundation

public enum SwikiVideoHosting: String, Decodable, Sendable {
    case vk
    case ok
    case coub
    case rutube
    case rutubeShorts = "rutube_shorts"
    case vimeo
    case youtube
    case youtubeShorts = "youtube_shorts"
    case sibnet
    case yandex
    case streamable
    case smotretAnime = "smotret_anime"
    case myvi
    case youmite
    case viuly
    case stormo
    case mediafile
}
