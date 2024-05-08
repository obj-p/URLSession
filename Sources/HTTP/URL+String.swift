import Foundation

public extension URL {
    static func from(string urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        return url
    }
}
