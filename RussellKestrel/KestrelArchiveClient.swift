import Foundation

struct ArchiveSearchRequest: Codable, Hashable {
    var channel: Int
    var start: Date
    var end: Date
}

struct ArchiveSegment: Codable, Identifiable, Hashable {
    var id: String { "\(channel)-\(start.timeIntervalSince1970)-\(end.timeIntervalSince1970)" }
    let channel: Int
    let start: Date
    let end: Date
    let playbackURL: URL?
}

/// Transport layer for the Kestrel recorder's HTTP archive API.
/// The Kestrel web UI was confirmed to expose a dedicated Playback page and
/// legacy JavaScript/ActiveX objects. The exact recorder search command is
/// kept isolated here so it can be filled in from a captured request without
/// touching the rest of the application.
final class KestrelArchiveClient {
    private let config: KestrelConfig
    private let session: URLSession

    init(config: KestrelConfig, session: URLSession = .shared) {
        self.config = config
        self.session = session
    }

    func openWebPlaybackURL() -> URL? {
        guard let base = config.webBaseURL else { return nil }
        return base.appendingPathComponent("playback.html")
    }

    func search(_ request: ArchiveSearchRequest) async throws -> [ArchiveSegment] {
        // Deliberately return no fabricated recordings. The recorder's exact
        // archive RPC must be captured from the Kestrel web interface before
        // native search can be implemented safely.
        _ = request
        _ = session
        return []
    }
}
