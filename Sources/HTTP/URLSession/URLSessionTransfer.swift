import Combine
import Foundation

class URLSessionTransfer: NSObject, Transfer {
    private var task: URLSessionDataTask
    private var subject = PassthroughSubject<DelegateEvent, Never>()
    private var subscriptions = Set<AnyCancellable>()

    init(task: URLSessionDataTask) {
        self.task = task
        super.init()
        task.delegate = self
    }

    func cancel() {
        task.cancel()
    }

    func receive(completion: @escaping (Response?, Error?) -> Void) {
        subject.sink { event in
            if case let .completed(response, error) = event {
                completion(response, error)
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
        defer {
            subject.send(completion: .finished)
        }

        guard let response = task.response as? HTTPURLResponse else {
            subject.send(.completed(nil, error))
            return
        }

        subject.send(.completed(Response(code: response.statusCode), error))
    }

    enum DelegateEvent {
        case completed(Response?, Error?)
        case received(Data)
    }
}
