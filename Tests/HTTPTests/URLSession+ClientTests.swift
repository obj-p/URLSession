import HTTP
import XCTest

final class URLSession_ClientTests: XCTestCase {
    func testExample() throws {
        // Given
        let origin = try Origin(scheme: .http, host: "localhost", port: 8080)
        let connection = URLSession.shared.connection(to: origin)

        // When
        let response = connection.send(.get())

        // Then
    }
}
