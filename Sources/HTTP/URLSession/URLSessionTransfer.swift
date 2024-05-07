import Combine
import Foundation

class URLSessionTransfer: NSObject, Transfer {
    private var task: URLSessionDataTask
    private var subject = PassthroughSubject<DelegateEvent, DelegateError>()
    private var subscriptions = Set<AnyCancellable>()

    init(task: URLSessionDataTask) {
        self.task = task
        super.init()
        task.delegate = self
    }

    func cancel() {
        task.cancel()
    }

    func response(receiveResponse: @escaping (Response) -> Void) {
        subject.sink(receiveCompletion: { _ in }) { event in
            if case let .completed(response) = event {
                receiveResponse(response)
            }
        }
        .store(in: &subscriptions)
    }

    func resume() {
        task.resume()
    }

    func suspend() {
        task.suspend()
    }
}

extension URLSessionTransfer: URLSessionDataDelegate {
    func urlSession(_: URLSession, dataTask _: URLSessionDataTask, didReceive data: Data) {
        subject.send(.received(data))
    }

    func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        guard let response = task.response as? HTTPURLResponse else {
            subject.send(completion: .failure(DelegateError.didCompleteWithError(error)))
            return
        }

        subject.send(.completed(Response(code: response.statusCode)))
    }

    enum DelegateEvent {
        case completed(Response)
        case received(Data)
    }

    enum DelegateError: Error {
        case didCompleteWithError(Error?)
    }
}
