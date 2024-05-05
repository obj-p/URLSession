public struct Method: ExpressibleByStringLiteral {
    public let verb: String

    public init(stringLiteral value: String) {
        self.init(verb: value)
    }

    public init(verb: String) {
        self.verb = verb
    }
}

public extension Method {
    static let delete: Method = "DELETE"
    static let get: Method = "GET"
    static let head: Method = "HEAD"
    static let options: Method = "OPTIONS"
    static let patch: Method = "PATCH"
    static let post: Method = "POST"
    static let put: Method = "PUT"
}
