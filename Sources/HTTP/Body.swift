import Foundation

public struct Body {
    public let data: Data
    public let mediaType: MediaType
}

public extension Body {
    static func text(_ text: String) -> Body? {
        text.data(using: .utf8).map {
            .init(data: $0, mediaType: MediaType.text)
        }
    }

    func text() -> String? {
        String(data: data, encoding: .utf8)
    }
}
