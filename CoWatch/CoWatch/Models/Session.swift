import Foundation

struct Session: Identifiable, Codable {
    enum Role: String, Codable {
        case host
        case guest
    }

    enum State: String, Codable {
        case lobby
        case playing
        case finished
    }

    let id: UUID
    var host: User
    var participants: [User]
    var contentItem: ContentItem?
    var state: State
    var startedAt: Date?

    init(id: UUID = UUID(), host: User, participants: [User] = [], contentItem: ContentItem? = nil, state: State = .lobby, startedAt: Date? = nil) {
        self.id = id
        self.host = host
        self.participants = participants
        self.contentItem = contentItem
        self.state = state
        self.startedAt = startedAt
    }
}
