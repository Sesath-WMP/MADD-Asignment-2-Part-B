import XCTest
@testable import CoWatch

final class QuizScoringTests: XCTestCase {
    func testScoreIncreasesOnCorrectAnswer() {
        let services = ServiceContainer()
        let item = ContentItem(title: "Test", description: "", thumbnailName: "", videoFileName: "", durationSeconds: 60)
        let vm = PlaybackViewModel(services: services, contentItem: item)

        let quiz = QuizItem(
            id: UUID(),
            question: "Q",
            choices: [QuizChoice(text: "A"), QuizChoice(text: "B")],
            correctIndex: 1,
            triggerTime: 0,
            points: 100
        )

        vm.activeQuiz = quiz
        vm.isQuizPresented = true

        vm.submitAnswer(index: 1)

        XCTAssertEqual(vm.userScore, 100)
    }
}
