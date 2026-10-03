import Foundation

struct CameraChannel: Identifiable, Codable, Hashable {
    let id: Int
    var name: String
    var enabled: Bool
    var rtspPath: String

    init(id: Int, name: String? = nil, enabled: Bool = true, rtspPath: String = "") {
        self.id = id
        self.name = name ?? "CAM \(id)"
        self.enabled = enabled
        self.rtspPath = rtspPath
    }
}

struct KestrelConfig: Codable, Equatable {
    var host: String = "192.168.0.18"
    var webPort: Int = 8081
    var rtspPort: Int = 8554
    var username: String = "admin"
    var password: String = ""
    var rtspTemplate: String = "rtsp://{host}:{port}/stream/{channel}"
    var archiveURLTemplate: String = "http://{host}:{webPort}/"
    var useExternalAddress: Bool = false
    var channels: [CameraChannel] = (1...16).map { CameraChannel(id: $0, enabled: $0 <= 5) }

    var webBaseURL: URL? {
        URL(string: "http://\(host):\(webPort)")
    }

    func rtspURL(for channel: Int) -> URL? {
        let s = rtspTemplate
            .replacingOccurrences(of: "{host}", with: host)
            .replacingOccurrences(of: "{port}", with: String(rtspPort))
            .replacingOccurrences(of: "{channel}", with: String(channel))
        return URL(string: s)
    }

    func archiveURL() -> URL? {
        let s = archiveURLTemplate
            .replacingOccurrences(of: "{host}", with: host)
            .replacingOccurrences(of: "{webPort}", with: String(webPort))
        return URL(string: s)
    }
}

final class ConfigStore: ObservableObject {
    @Published var config: KestrelConfig {
        didSet { save() }
    }

    private let key = "RussellKestrel.config.v5"

    init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let value = try? JSONDecoder().decode(KestrelConfig.self, from: data) {
            config = value
        } else {
            config = KestrelConfig()
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(config) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
