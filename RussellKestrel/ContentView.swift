import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: ConfigStore
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            LiveView().tabItem { Label("Live", systemImage: "camera.fill") }.tag(0)
            PlaybackView().tabItem { Label("Playback", systemImage: "clock.fill") }.tag(1)
            SettingsView().tabItem { Label("Settings", systemImage: "gearshape.fill") }.tag(2)
        }
    }
}
