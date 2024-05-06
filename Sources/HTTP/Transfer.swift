public protocol Transfer {
    func cancel()
    func response(receiveResponse: @escaping (Response) -> Void)
}
