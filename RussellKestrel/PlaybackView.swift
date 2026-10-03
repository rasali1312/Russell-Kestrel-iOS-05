import SwiftUI

struct PlaybackView: View {
    @EnvironmentObject private var store: ConfigStore
    @State private var date = Date()
    @State private var camera = 1
    @State private var showWeb = true

    var body: some View {
        NavigationView {
            Form {
                Section("Search") {
                    Picker("Camera", selection: $camera) {
                        ForEach(store.config.channels.filter { $0.enabled }) { c in
                            Text(c.name).tag(c.id)
                        }
                    }
                    DatePicker("Date / time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }

                Section("Kestrel archive") {
                    Toggle("Use Kestrel web playback", isOn: $showWeb)
                    if showWeb {
                        KestrelWebView(url: store.config.webBaseURL)
                            .frame(minHeight: 520)
                    } else {
                        Text("The native archive protocol is intentionally isolated in KestrelArchiveClient so we can add the exact request discovered from the Kestrel web interface without changing the UI.")
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("Playback")
        }
    }
}
