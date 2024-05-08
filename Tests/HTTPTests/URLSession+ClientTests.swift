import HTTP
import XCTest

final class URLSession_ClientTests: XCTestCase {
    func testGETEcho() throws {
        // Given
        let connection = try URLSession.shared.connection(to: "http://localhost:8080")
        let expectation = expectation(description: "response is received")
        let transfer = connection.transfer(.get(), appending: "echo")

        transfer.receive { response, _ in
            XCTAssertEqual(200, response?.code)
            expectation.fulfill()
        }

        // When
        transfer.resume()

        // Then
        wait(for: [expectation], timeout: 1)
    }
}
