import AVKit
import SwiftUI

struct RTSPPlayerView: View {
    let url: URL

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "play.rectangle.fill")
                .font(.system(size: 44))
            Text("RTSP source configured")
                .font(.headline)
            Text(url.absoluteString)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            Text("Apple AVPlayer does not natively decode arbitrary RTSP streams. This placeholder keeps the project dependency-free; a native RTSP engine can be added later without changing the DVR model/UI.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 240)
        .background(Color.secondary.opacity(0.12))
    }
}
