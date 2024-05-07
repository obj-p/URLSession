public protocol Transfer {
    func cancel()
    func response(receiveResponse: @escaping (Response) -> Void)
    func resume()
    func suspend()
}
