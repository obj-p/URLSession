import HTTP
import XCTest

final class URLSession_ClientTests: XCTestCase {
    func testGETEcho() throws {
        // Given
        let url = URL(string: "http://localhost:8080/echo")!
        let expectation = expectation(description: "response is received")
        let transfer = URLSession.shared.transfer(.get(), to: url)

        transfer.response { response in
            XCTAssertEqual(200, response.code)
            expectation.fulfill()
        }

        // When
        transfer.resume()

        // Then
        wait(for: [expectation], timeout: 1)
    }
}
