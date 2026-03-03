import Logging
import SwiftUI

@main
struct SwikiExampleApp: App {
    @StateObject private var viewModel = ExampleAppViewModel()

    init() {
        LoggingSystem.bootstrap(StreamLogHandler.standardOutput)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(viewModel: viewModel)
            }
        }
    }
}
