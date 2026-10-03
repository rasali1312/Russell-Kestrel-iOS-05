import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: ConfigStore

    var body: some View {
        NavigationView {
            Form {
                Section("DVR connection") {
                    TextField("Host / IP / external address", text: $store.config.host)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                    TextField("Web port", value: $store.config.webPort, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("RTSP port", value: $store.config.rtspPort, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("Username", text: $store.config.username)
                        .autocapitalization(.none)
                    SecureField("Password", text: $store.config.password)
                }

                Section("Stream templates") {
                    TextField("RTSP template", text: $store.config.rtspTemplate)
                        .autocapitalization(.none)
                    TextField("Archive base URL", text: $store.config.archiveURLTemplate)
                        .autocapitalization(.none)
                    Text("Placeholders: {host}, {port}, {channel}, {webPort}")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }

                Section("Channels") {
                    ForEach(store.config.channels.indices, id: \.self) { index in
                        Toggle(store.config.channels[index].name, isOn: $store.config.channels[index].enabled)
                    }
                }

                Section("Version") {
                    Text("Russell Kestrel iOS — Version 5")
                    Text("Deployment target: iOS 15+, designed for current iOS including iOS 26.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
