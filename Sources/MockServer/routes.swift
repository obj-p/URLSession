import Vapor

func routes(_ app: Application) throws {
    app.get("echo", use: echo)

    app.post("echo", use: echo)
}

private func echo(request: Request) async -> Response {
    guard let contentType = request.content.contentType, let string = request.body.string else {
        return .init(status: .ok)
    }

    var headers = HTTPHeaders()
    headers.add(name: .contentType, value: contentType.description)
    return .init(status: .ok, headers: headers, body: .init(string: string))
}
