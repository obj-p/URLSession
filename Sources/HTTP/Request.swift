import Foundation

public struct Request {
    public let body: Body?
    public let method: Method

    public init(method: Method, body: Body? = nil) {
        self.body = body
        self.method = method
    }
}

public extension Request {
    static func get(body: Body? = nil) -> Request {
        Request(method: .get, body: body)
    }
}
