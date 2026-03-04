import Foundation

public struct SwikiClubLogo: Decodable, Sendable {
    public let original: URL
    public let preview: URL
    public let x96: URL?
    public let x48: URL?
    public let x73: URL?
}
