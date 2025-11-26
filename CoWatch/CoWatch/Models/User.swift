import Foundation
import SwiftUI

struct User: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var avatarColorHex: String
    var totalScore: Int

    init(id: UUID = UUID(), name: String, avatarColorHex: String, totalScore: Int = 0) {
        self.id = id
        self.name = name
        self.avatarColorHex = avatarColorHex
        self.totalScore = totalScore
    }
}

extension User {
    static let placeholderHost = User(name: "You", avatarColorHex: "#66FFCC")
}
