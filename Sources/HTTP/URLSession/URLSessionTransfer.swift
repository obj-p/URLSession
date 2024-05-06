import Combine
import Foundation

class URLSessionTransfer: Transfer {
    private var task: URLSessionDataTask
    private var future: Future<Response, Never>!
    private var subscriptions = Set<AnyCancellable>()

    init(task: URLSessionDataTask) {
        self.task = task
        future = Future { promise in
            task.delegate = TaskDelegate { _ in
                promise(.success(.init())) // TODO:
            }
        }
    }

    func cancel() {
        task.cancel()
    }

    func response(_ onResponse: @escaping (Response) -> Void) {
        future
            .sink(receiveValue: onResponse)
            .store(in: &subscriptions)
    }

    typealias Output = Result<Response, Error>

    private class TaskDelegate: NSObject, URLSessionTaskDelegate {
        let completion: (Output) -> Void

        init(completion: @escaping (Output) -> Void) {
            self.completion = completion
        }

        func urlSession(_: URLSession, task _: URLSessionTask, didCompleteWithError _: (any Error)?) {
            completion(.success(.init())) // TODO:
        }
    }
}
