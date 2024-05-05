import HTTP
import XCTest

final class URLSession_ClientTests: XCTestCase {
    func testExample() {
        // Given
        let request = Request(urlString: "https://google.com")!
        let urlSession = URLSession.shared

        // When
        urlSession.send(request)

        // Then
    }
}
