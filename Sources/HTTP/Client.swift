import Foundation

public protocol Client {
    func connection(to origin: Origin) -> Connection
    func send(_ request: Request, to origin: Origin) -> Response
}
