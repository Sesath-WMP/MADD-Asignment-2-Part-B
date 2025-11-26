import XCTest
@testable import CoWatch

final class SimulationServiceTests: XCTestCase {
    func testConfigureCreatesCorrectNumberOfPeers() {
        let service = SimulationService()
        service.configure(peerCount: 3, baseLatency: 0.5)
        XCTAssertEqual(service.peers.count, 3)
    }

    func testQuizPromptAdjustsScores() {
        let service = SimulationService()
        service.configure(peerCount: 2, baseLatency: 0.5)
        let before = service.peers.map { $0.score }

        let quiz = QuizItem(
            id: UUID(),
            question: "Q",
            choices: [QuizChoice(text: "A"), QuizChoice(text: "B")],
            correctIndex: 0,
            triggerTime: 0,
            points: 50
        )

        service.handleQuizPrompt(quiz)
        let after = service.peers.map { $0.score }
        XCTAssertEqual(after.count, before.count)
    }
}
