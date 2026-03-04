import Foundation

public struct SwikiUserImagePayload: Sendable {
    public let image: URL
    public let linkedType: String?

    public init(image: URL, linkedType: String?) {
        self.image = image
        self.linkedType = linkedType
    }

    func multipart() throws -> (contentType: String, body: Data) {
        var mp = MultipartFormData()
        if let linkedType {
            mp.addField("linked_type", linkedType)
        }
        try mp.addFile(name: "image", fileURL: image)
        return (mp.contentTypeHeaderValue, mp.build())
    }

}
