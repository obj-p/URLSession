import Foundation

public extension URLSession {
    func connection(to origin: Origin) -> Connection {
        .init(client: self, origin: origin)
    }

    func send(_: Request, to _: Origin) -> Response {
        .init()
    }
}

extension URLSession: Client {}
