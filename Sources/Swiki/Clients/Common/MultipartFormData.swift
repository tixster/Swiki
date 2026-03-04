import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

#if canImport(UniformTypeIdentifiers)
import UniformTypeIdentifiers
#endif

public struct MultipartFormData {
    public let boundary: String
    private var body = Data()

    public init(boundary: String = "Boundary-\(UUID().uuidString)") {
        self.boundary = boundary
    }

    public var contentTypeHeaderValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    @discardableResult
    public mutating func addField(_ name: String, _ value: String?) -> Self {
        guard let value else { return self }
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(escape(name))\"\r\n\r\n")
        body.append("\(value)\r\n")
        return self
    }

    @discardableResult
    public mutating func addFile(
        name: String,
        fileURL: URL,
        filename overrideFilename: String? = nil,
        mimeType overrideMimeType: String? = nil
    ) throws -> Self {
        let data = try Data(contentsOf: fileURL)
        let filename = overrideFilename ?? fileURL.lastPathComponent
        let mimeType = overrideMimeType ?? Self.mimeType(for: fileURL) ?? "application/octet-stream"
        return addFile(name: name, filename: filename, mimeType: mimeType, data: data)
    }

    @discardableResult
    public mutating func addFile(
        name: String,
        filename: String,
        mimeType: String,
        data: Data
    ) -> Self {
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(escape(name))\"; filename=\"\(escape(filename))\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.append("\r\n")
        return self
    }

    public func build() -> Data {
        var out = body
        out.append("--\(boundary)--\r\n")
        return out
    }

    // MARK: - Helpers

    private func escape(_ s: String) -> String {
        s.replacingOccurrences(of: "\"", with: "%22")
    }

    private static func mimeType(for url: URL) -> String? {
        let ext = url.pathExtension
        guard !ext.isEmpty else { return nil }

        #if canImport(UniformTypeIdentifiers)
        if let type = UTType(filenameExtension: ext),
           let mime = type.preferredMIMEType {
            return mime
        }
        #endif

        // Fallback for Linux (and any platform without UTType).
        switch ext.lowercased() {
        case "jpg", "jpeg": return "image/jpeg"
        case "png": return "image/png"
        case "gif": return "image/gif"
        case "webp": return "image/webp"
        case "heic": return "image/heic"
        case "pdf": return "application/pdf"
        case "mp4": return "video/mp4"
        default: return "application/octet-stream"
        }
    }
}

private extension Data {
    mutating func append(_ string: String) {
        self.append(string.data(using: .utf8)!)
    }
}