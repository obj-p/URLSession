import Foundation

public protocol Client {
    func connection(to url: URL) -> Connection
    func transfer(_ request: Request, to url: URL) -> Transfer
}
