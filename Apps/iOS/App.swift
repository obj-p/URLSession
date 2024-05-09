import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            VStack {
                Spacer()
                HTTPView()
            }
            .background(.blue)
        }
    }
}
