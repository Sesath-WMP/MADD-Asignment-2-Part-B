import Foundation

struct ContentItem: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let description: String
    let thumbnailName: String
    let videoFileName: String
    let durationSeconds: Double

    init(id: UUID = UUID(), title: String, description: String, thumbnailName: String, videoFileName: String, durationSeconds: Double) {
        self.id = id
        self.title = title
        self.description = description
        self.thumbnailName = thumbnailName
        self.videoFileName = videoFileName
        self.durationSeconds = durationSeconds
    }
}
