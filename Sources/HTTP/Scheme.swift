public struct Scheme: ExpressibleByStringLiteral {
    public let `protocol`: String

    public init(stringLiteral value: String) {
        self.init(protocol: value)
    }

    public init(protocol: String) {
        self.protocol = `protocol`
    }
}

public extension Scheme {
    static let http: Scheme = "http"
    static let https: Scheme = "https"
}
