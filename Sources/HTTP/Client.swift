import Foundation

public protocol Client {
    func connection(to url: URL) -> Connection
    func transfer(_ request: Request, to url: URL) -> Transfer
}

public extension Client {
    func connection(to urlString: String) throws -> Connection {
        try connection(to: URL.from(string: urlString))
    }

    func transfer(_ request: Request, to urlString: String) throws -> Transfer {
        try transfer(request, to: URL.from(string: urlString))
    }
}

private extension URL {
    static func from(string urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        return url
    }
}
