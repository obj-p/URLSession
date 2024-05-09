public struct MediaType: CustomStringConvertible {
    public var description: String {
        var description = "\(type)/\(subtype)"

        if let parameters {
            for (key, value) in parameters {
                description += ";\(key)=\(value)"
            }
        }

        return description
    }

    public let type: String
    public let subtype: String
    public let parameters: [Parameter: String]?

    public init(type: String, subtype: String, parameters: [Parameter: String]? = nil) {
        self.type = type
        self.subtype = subtype
        self.parameters = parameters
    }

    public struct Parameter: CustomStringConvertible, Equatable, ExpressibleByStringLiteral, Hashable {
        public var description: String {
            key
        }

        public let key: String

        public static func == (lhs: Parameter, rhs: Parameter) -> Bool {
            lhs.key.lowercased() == rhs.key.lowercased()
        }

        public init(stringLiteral value: StringLiteralType) {
            key = value
        }

        public init(key: String) {
            self.key = key
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(key.lowercased())
        }
    }
}

public extension MediaType {
    static let binary = MediaType(type: "application", subtype: "octet-stream")
    static let json = MediaType(type: "application", subtype: "json", parameters: [.charset: "utf-8"])
    static let text = MediaType(type: "text", subtype: "plain", parameters: [.charset: "utf-8"])
}

public extension MediaType.Parameter {
    static let charset: MediaType.Parameter = "charset"
}
