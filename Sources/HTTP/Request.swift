import Foundation

public struct Request {
    // swiftlint:disable:next todo
    public var body: Body? // TODO: GET is not allowed to have a body
    public var method: Method

    public init(method: Method, body: Body? = nil) {
        self.body = body
        self.method = method
    }

    public func urlRequest(url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.verb

        if let body {
            urlRequest.httpBody = body.data
            urlRequest.setValue(
                // swiftlint:disable:next todo
                body.mediaType.description, forHTTPHeaderField: "Content-Type" // TODO: extract constant
            )
        }

        return urlRequest
    }
}

public extension Request {
    static func get() -> Request {
        Request(method: .get)
    }

    static func post(_ body: Body) -> Request {
        Request(method: .post, body: body)
    }
}
