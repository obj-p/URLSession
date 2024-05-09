import HTTP
import XCTest

final class URLSession_ClientTests: XCTestCase {
    var connection: Connection!

    override func setUpWithError() throws {
        connection = try URLSession.shared.connection(to: "http://localhost:8080")
        try super.setUpWithError()
    }

    func testGETEcho() throws {
        // Given
        let body = Body.text("Hello, world!")!
        let expectation = expectation(description: "response is received")
        let transfer = connection.transfer(.post(body), toPath: "echo")

        transfer.receive { response, _ in
            XCTAssertEqual(200, response?.code)
            XCTAssertEqual("Hello, world!", response?.body?.text())
            expectation.fulfill()
        }

        // When
        transfer.resume()

        // Then
        wait(for: [expectation], timeout: 1)
    }
}
