import Foundation
import SwiftUI

struct SimulatedPeer: Identifiable {
    let id: UUID
    var user: User
    var latency: TimeInterval
    var score: Int
}

protocol SimulationServiceProtocol: AnyObject {
    var peers: [SimulatedPeer] { get }
    var onPeersChanged: (([SimulatedPeer]) -> Void)? { get set }

    func configure(peerCount: Int, baseLatency: TimeInterval)
    func simulateJoinLobby()
    func handleHostPlay(at time: TimeInterval)
    func handleHostPause(at time: TimeInterval)
    func handleTimeSync(hostTime: TimeInterval)
    func handleQuizPrompt(_ quiz: QuizItem)
    func resetScores()
}

final class SimulationService: SimulationServiceProtocol {
    private(set) var peers: [SimulatedPeer] = [] {
        didSet { onPeersChanged?(peers) }
    }

    var onPeersChanged: (([SimulatedPeer]) -> Void)?

    private let namesPool = ["Nova", "Orion", "Lyra", "Vega", "Zen", "Echo"]
    private let avatarColors = ["#D7FF5E", "#66FFCC", "#FF9A1A"]

    private var baseLatency: TimeInterval = 0.5
    private var random = SystemRandomNumberGenerator()

    func configure(peerCount: Int, baseLatency: TimeInterval) {
        self.baseLatency = baseLatency
        peers = (0..<peerCount).map { index in
            let name = namesPool[index % namesPool.count]
            let color = avatarColors[index % avatarColors.count]
            let user = User(name: name, avatarColorHex: color)
            let jitter = Double.random(in: -0.2...0.2, using: &random)
            return SimulatedPeer(id: user.id, user: user, latency: max(0.1, baseLatency + jitter), score: 0)
        }
    }

    func simulateJoinLobby() {
        // For prototype we simply fire peersChanged; real networking would emit events
        onPeersChanged?(peers)
    }

    func handleHostPlay(at time: TimeInterval) {
        // Could schedule their local playback; here it is only conceptual
    }

    func handleHostPause(at time: TimeInterval) {
    }

    func handleTimeSync(hostTime: TimeInterval) {
        // In a real app, peers would adjust; here we keep it conceptual
    }

    func handleQuizPrompt(_ quiz: QuizItem) {
        // Simple behavior: each peer answers with some probability of being correct
        var updated: [SimulatedPeer] = []
        for var peer in peers {
            let willAnswerCorrectly = Bool.random(using: &random)
            if willAnswerCorrectly {
                peer.score += quiz.points
            }
            updated.append(peer)
        }
        peers = updated
    }

    func resetScores() {
        peers = peers.map { peer in
            var copy = peer
            copy.score = 0
            return copy
        }
    }
}
