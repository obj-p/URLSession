import Combine

public protocol Transfer {
    func cancel()
    func response(_ onResponse: @escaping (Response) -> Void)
//    func onCompletion(_ completion: @escaping (Response) -> Void)
//    func publisher() -> AnyPublisher<Response, Error>
}
