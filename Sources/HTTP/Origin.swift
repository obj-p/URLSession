import Foundation

public struct Origin {
    public let host: String
    public let port: UInt?
    public let scheme: Scheme

    public init(scheme: Scheme, host: String, port: UInt? = nil) throws {
        if host.rangeOfCharacter(from: .urlHostAllowed.inverted) != nil {
            throw Error.invalidHost
        }

        self.host = host
        self.port = port
        self.scheme = scheme
    }

    enum Error: Swift.Error {
        case invalidHost
    }
}

public extension Origin {
    var url: URL! {
        if let port {
            URL(string: "\(scheme)://\(host):\(port)")
        } else {
            URL(string: "\(scheme)://\(host)")
        }
    }
}
