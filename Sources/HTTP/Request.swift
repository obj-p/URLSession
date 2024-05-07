import Foundation

public struct Request {
    public var body: Body?
    public var method: Method

    public init(method: Method, body: Body? = nil) {
        self.body = body
        self.method = method
    }

    public func urlRequest(url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = body?.data
        urlRequest.httpMethod = method.verb
        return urlRequest
    }
}

public extension Request {
    static func get(body: Body? = nil) -> Request {
        Request(method: .get, body: body)
    }
}
