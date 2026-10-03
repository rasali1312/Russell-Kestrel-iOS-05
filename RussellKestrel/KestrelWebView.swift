import SwiftUI
import WebKit

struct KestrelWebView: UIViewRepresentable {
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.allowsBackForwardNavigationGestures = true
        if let url = url {
            view.load(URLRequest(url: url))
        }
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = url else { return }
        if uiView.url?.host != url.host || uiView.url?.port != url.port {
            uiView.load(URLRequest(url: url))
        }
    }
}
