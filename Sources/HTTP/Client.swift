import Foundation

public protocol Client {
    func send(_ request: Request) -> Response
}
