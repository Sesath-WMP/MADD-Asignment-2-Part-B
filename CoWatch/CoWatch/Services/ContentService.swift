import Foundation

protocol ContentServiceProtocol {
    func loadContent() -> [ContentItem]
    func loadQuizPack() -> QuizPack?
}

final class ContentService: ContentServiceProtocol {
    private let seedFileName = "SeedContent"

    func loadContent() -> [ContentItem] {
        guard let url = Bundle.main.url(forResource: seedFileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        do {
            let decoded = try JSONDecoder().decode(SeedPayload.self, from: data)
            return decoded.content
        } catch {
            return []
        }
    }

    func loadQuizPack() -> QuizPack? {
        guard let url = Bundle.main.url(forResource: seedFileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        do {
            let decoded = try JSONDecoder().decode(SeedPayload.self, from: data)
            return decoded.quizPack
        } catch {
            return nil
        }
    }
}

struct SeedPayload: Codable {
    let content: [ContentItem]
    let quizPack: QuizPack
}
