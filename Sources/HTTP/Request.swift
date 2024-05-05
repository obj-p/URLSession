import Foundation

public struct Request {
    public let body: Body?
    public let method: Method
    public let url: URL

    public init?(
        urlString: String,
        method: Method = .get,
        body: Body? = nil
    ) {
        if let url = URL(string: urlString) {
            self.init(url: url, method: method, body: body)
        } else {
            return nil
        }
    }

    public init(
        url: URL,
        method: Method = .get,
        body: Body? = nil
    ) {
        self.body = body
        self.method = method
        self.url = url
    }
}
