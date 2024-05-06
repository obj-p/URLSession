import HTTP
import XCTest

final class URLSession_ClientTests: XCTestCase {
    func testExample() throws {
        // Given
        let url = URL(string: "http://localhost:8080")!
        let connection = URLSession.shared.connection(to: url)
        let expectation = expectation(description: "response is received")

        // When
        connection.submit(.get()).response { response in
            XCTAssertEqual(200, response.code)
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)
    }
}
