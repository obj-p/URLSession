import Foundation

public struct Connection {
    public let client: Client
    public let url: URL

    public init(client: Client, url: URL) {
        self.client = client
        self.url = url
    }
}

public extension Connection {
    func transfer(_ request: Request) -> Transfer {
        client.transfer(request, to: url)
    }
}
