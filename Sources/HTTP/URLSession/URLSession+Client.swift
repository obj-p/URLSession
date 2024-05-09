import Foundation

extension URLSession: Client {
    public func connection(to url: URL) -> Connection {
        .init(client: self, url: url)
    }

    public func transfer(_ request: Request, to url: URL) -> Transfer {
        let urlRequest = request.urlRequest(url: url)
        let task = dataTask(with: urlRequest)
        let transfer = URLSessionTransfer(task: task)
        return transfer
    }
}
