import Vapor

func routes(_ app: Application) throws {
    app.get("echo") { request async -> String in
        request.body.string ?? ""
    }
}
