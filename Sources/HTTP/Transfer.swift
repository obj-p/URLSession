public protocol Transfer {
    func cancel()
    func receive(completion: @escaping (Response?, Error?) -> Void)
    func resume()
    func suspend()
}
