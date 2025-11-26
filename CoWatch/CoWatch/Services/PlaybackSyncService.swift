import Foundation
import AVFoundation

protocol PlaybackSyncServiceProtocol: AnyObject {
    var currentTime: TimeInterval { get }
    var isPlaying: Bool { get }
    var onTick: ((TimeInterval) -> Void)? { get set }

    func attach(player: AVPlayer)
    func hostPlay()
    func hostPause()
    func hostSeek(to time: TimeInterval)
    func applySync(targetTime: TimeInterval, latency: TimeInterval)
}

final class PlaybackSyncService: PlaybackSyncServiceProtocol {
    private weak var player: AVPlayer?
    private var displayLink: CADisplayLink?

    var onTick: ((TimeInterval) -> Void)?

    var currentTime: TimeInterval {
        guard let player else { return 0 }
        return player.currentTime().seconds
    }

    var isPlaying: Bool {
        player?.timeControlStatus == .playing
    }

    func attach(player: AVPlayer) {
        self.player = player
        configureDisplayLink()
    }

    func hostPlay() {
        player?.play()
    }

    func hostPause() {
        player?.pause()
    }

    func hostSeek(to time: TimeInterval) {
        let cm = CMTime(seconds: time, preferredTimescale: 600)
        player?.seek(to: cm)
    }

    func applySync(targetTime: TimeInterval, latency: TimeInterval) {
        // Simple approximation: nudge toward host time factoring in latency
        let adjusted = targetTime + latency
        let delta = adjusted - currentTime
        guard abs(delta) > 0.25 else { return }
        hostSeek(to: adjusted)
    }

    private func configureDisplayLink() {
        displayLink?.invalidate()
        let link = CADisplayLink(target: self, selector: #selector(handleTick))
        link.preferredFramesPerSecond = 2
        link.add(to: .main, forMode: .common)
        displayLink = link
    }

    @objc private func handleTick() {
        onTick?(currentTime)
    }

    deinit {
        displayLink?.invalidate()
    }
}
