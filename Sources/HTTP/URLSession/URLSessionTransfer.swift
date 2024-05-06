import Combine
import Foundation

class URLSessionTransfer: Transfer {
    private var task: URLSessionDataTask
    private var future: Future<Response, Never>!
    private var subscriptions = Set<AnyCancellable>()

    init(task: URLSessionDataTask) {
        self.task = task
        future = Future { promise in
            task.delegate = TaskDelegate { response in
                withExtendedLifetime(self) {
                    promise(.success(response))
                }
            }
        }
    }

    func cancel() {
        task.cancel()
    }

    func response(receiveResponse: @escaping (Response) -> Void) {
        future
            .sink(receiveValue: receiveResponse)
            .store(in: &subscriptions)
    }

    private class TaskDelegate: NSObject, URLSessionTaskDelegate {
        let completion: (Response) -> Void

        init(completion: @escaping (Response) -> Void) {
            self.completion = completion
        }

        func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
            guard let response = task.response as? HTTPURLResponse else {
                fatalError() // TODO:
            }

            completion(.init(body: nil, code: response.statusCode, error: error))
        }
    }
}
