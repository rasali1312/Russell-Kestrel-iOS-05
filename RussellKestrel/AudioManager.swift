import AVFoundation
import Foundation

final class AudioManager: NSObject, ObservableObject {
    @Published private(set) var isPrepared = false
    @Published private(set) var isTalking = false

    private let session = AVAudioSession.sharedInstance()

    func prepareForPlayback() {
        do {
            try session.setCategory(.playback, mode: .moviePlayback, options: [.allowBluetooth, .allowAirPlay])
            try session.setActive(true)
            isPrepared = true
        } catch {
            isPrepared = false
        }
    }

    func startTalk() throws {
        try session.setCategory(.playAndRecord, mode: .voiceChat, options: [.allowBluetooth, .defaultToSpeaker])
        try session.setActive(true)
        isTalking = true
    }

    func stopTalk() {
        isTalking = false
        try? session.setCategory(.playback, mode: .moviePlayback, options: [.allowBluetooth, .allowAirPlay])
        try? session.setActive(true)
    }
}
