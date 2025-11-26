import Foundation
import Combine
import AVFoundation

final class PlaybackViewModel: ObservableObject {
    @Published var isQuizPresented: Bool = false
    @Published var activeQuiz: QuizItem?
    @Published var userScore: Int = 0
    @Published var leaderboardUsers: [User] = []

    let player: AVPlayer
    let contentItem: ContentItem

    private let services: ServiceContainer
    private let quizPack: QuizPack?
    private var firedQuizIDs: Set<UUID> = []

    init(services: ServiceContainer, contentItem: ContentItem) {
        self.services = services
        self.contentItem = contentItem
        self.player = AVPlayer()
        self.quizPack = services.contentService.loadQuizPack()

        services.playbackSyncService.attach(player: player)
        services.playbackSyncService.onTick = { [weak self] time in
            self?.handleTick(time: time)
        }
    }

    func hostPlay() {
        services.playbackSyncService.hostPlay()
        services.simulationService.handleHostPlay(at: services.playbackSyncService.currentTime)
    }

    func hostPause() {
        services.playbackSyncService.hostPause()
        services.simulationService.handleHostPause(at: services.playbackSyncService.currentTime)
    }

    func submitAnswer(index: Int) {
        guard let quiz = activeQuiz else { return }
        let correct = index == quiz.correctIndex
        if correct {
            userScore += quiz.points
        }
        services.simulationService.handleQuizPrompt(quiz)
        isQuizPresented = false
        activeQuiz = nil

        // Update leaderboard users after quiz
        let hostUser = services.persistenceService.loadUserProfile()
        var host = hostUser
        host.totalScore = userScore
        let peers = services.simulationService.peers
        var users: [User] = [host]
        users.append(contentsOf: peers.map { peer in
            var user = peer.user
            user.totalScore = peer.score
            return user
        })
        leaderboardUsers = users.sorted { $0.totalScore > $1.totalScore }
    }

    private func handleTick(time: TimeInterval) {
        guard let quizPack else { return }
        guard !isQuizPresented else { return }
        for quiz in quizPack.items where !firedQuizIDs.contains(quiz.id) {
            if time >= quiz.triggerTime {
                firedQuizIDs.insert(quiz.id)
                DispatchQueue.main.async { [weak self] in
                    self?.activeQuiz = quiz
                    self?.isQuizPresented = true
                }
                break
            }
        }
    }
}
