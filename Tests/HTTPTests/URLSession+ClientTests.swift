import HTTP
import XCTest

final class URLSession_ClientTests: XCTestCase {
    func testExample() throws {
        // Given
        let url = URL(string: "http://localhost:8080")!
        let connection = URLSession.shared.connection(to: url)
        let expectation = expectation(description: "response is received")

        // When
        connection.submit(.get()).response { _ in
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)
    }
}
