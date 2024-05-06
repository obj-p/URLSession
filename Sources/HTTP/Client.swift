import Foundation

public protocol Client {
    func connection(to url: URL) -> Connection
    func submit(_ request: Request, to url: URL) -> Transfer
}
