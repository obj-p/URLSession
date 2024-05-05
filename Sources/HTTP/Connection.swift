public struct Connection {
    public let client: Client
    public let origin: Origin

    public init(client: Client, origin: Origin) {
        self.client = client
        self.origin = origin
    }
}

public extension Connection {
    func send(_: Request) -> Response {
        .init()
    }
}
