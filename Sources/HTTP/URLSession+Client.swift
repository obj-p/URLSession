import Foundation

public extension URLSession {
    func send(_: Request) -> Response {
        .init()
    }
}

extension URLSession: Client {}
