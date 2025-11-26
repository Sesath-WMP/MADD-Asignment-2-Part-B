import Foundation
import Combine

final class LeaderboardViewModel: ObservableObject {
    @Published var users: [User]

    init(users: [User]) {
        self.users = users.sorted { $0.totalScore > $1.totalScore }
    }
}
