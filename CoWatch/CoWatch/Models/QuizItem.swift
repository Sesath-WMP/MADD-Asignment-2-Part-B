import Foundation

struct QuizChoice: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String

    init(id: UUID = UUID(), text: String) {
        self.id = id
        self.text = text
    }
}

struct QuizItem: Identifiable, Codable, Equatable {
    let id: UUID
    let question: String
    let choices: [QuizChoice]
    let correctIndex: Int
    /// Seconds into the video when this quiz should appear
    let triggerTime: Double
    let points: Int
}

struct QuizPack: Codable {
    let items: [QuizItem]
}
