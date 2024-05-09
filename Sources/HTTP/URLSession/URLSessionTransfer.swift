import Combine
import Foundation

class URLSessionTransfer: NSObject, Transfer {
    private var data: Data?
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
    func urlSession(
        _: URLSession,
        dataTask: URLSessionDataTask,
        didReceive _: URLResponse,
        completionHandler: @escaping @Sendable (URLSession.ResponseDisposition) -> Void
    ) {
        if dataTask.countOfBytesExpectedToReceive > 0 {
            data = Data()
        }

        completionHandler(.allow)
    }

    func urlSession(_: URLSession, dataTask _: URLSessionDataTask, didReceive data: Data) {
        self.data?.append(data)
    }

    func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        defer {
            subject.send(completion: .finished)
        }

        guard let httpURLResponse = task.response as? HTTPURLResponse else {
            subject.send(.completed(nil, error))
            return
        }

        let body = data.map {
            // swiftlint:disable:next todo
            Body(data: $0, mediaType: .text) // TODO: update mediaType from headers
        }

        let response = Response(body: body, code: httpURLResponse.statusCode)
        subject.send(.completed(response, error))
    }

    enum DelegateEvent {
        case completed(Response?, Error?)
    }
}
