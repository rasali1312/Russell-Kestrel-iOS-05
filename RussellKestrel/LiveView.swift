import SwiftUI

struct LiveView: View {
    @EnvironmentObject private var store: ConfigStore
    @State private var selectedCamera = 1
    @State private var webFallback = false

    private var enabledChannels: [CameraChannel] {
        store.config.channels.filter { $0.enabled }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    Picker("Camera", selection: $selectedCamera) {
                        ForEach(enabledChannels) { camera in
                            Text(camera.name).tag(camera.id)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    if let url = store.config.rtspURL(for: selectedCamera) {
                        RTSPPlayerView(url: url)
                            .frame(minHeight: 240)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }

                    Toggle("Kestrel web fallback", isOn: $webFallback)
                        .padding(.horizontal)

                    if webFallback {
                        KestrelWebView(url: store.config.webBaseURL)
                            .frame(minHeight: 500)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }

                    Text("Live stream uses the configured RTSP URL. If the Kestrel recorder exposes a browser-only stream, use the web fallback while we map its native playback protocol.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .navigationTitle("Russell Kestrel")
            .onAppear {
                if !enabledChannels.contains(where: { $0.id == selectedCamera }), let first = enabledChannels.first {
                    selectedCamera = first.id
                }
            }
        }
    }
}
