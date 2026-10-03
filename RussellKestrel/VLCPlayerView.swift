import SwiftUI

// Kept for source compatibility with earlier Version 4 files.
// Version 5 intentionally has no VLCKit dependency, fixing the previous
// "no such module 'VLCKit'" build failure.
struct VLCPlayerView: View {
    let url: URL?

    var body: some View {
        RTSPPlayerView(url: url ?? URL(string: "about:blank")!)
    }
}
