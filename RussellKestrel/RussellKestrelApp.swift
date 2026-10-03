import SwiftUI

@main
struct RussellKestrelApp: App {
    @StateObject private var store = ConfigStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
