# Russell Kestrel iOS — Version 5

Dependency-free SwiftUI project for the OYN-X Kestrel/TW_IDM400-family DVR.

## What Version 5 fixes
- No `VLCKit` import or binary dependency.
- No `NavigationStack`; uses `NavigationView` for compatibility with older SDKs.
- No iOS-16-only multiline `TextField(axis:)` initializer.
- `Info.plist` is explicitly excluded from the source resource list to prevent the previous duplicate `Info.plist` build error.
- Workflow files live outside the app target, preventing the previous `build-unsigned-ipa.yml` duplicate-resource error.
- Supports 16 configured channels and can be expanded without changing the data model.
- Includes a Kestrel web playback fallback and an isolated archive transport layer.
- Audio session manager is included for future live/archive/two-way audio integration.

## iOS 26
The deployment target is iOS 15.0 so the same app can run on iOS 26. The GitHub workflow selects the installed Xcode 26 toolchain when available, which is required to build against the iOS 26 SDK.

## Important Kestrel protocol note
The Kestrel web analysis confirms a Playback page and legacy JavaScript/ActiveX integration. Version 5 does **not** invent an archive RPC. Native archive search/playback should be wired to the exact HTTP request captured from the browser before implementing it.
