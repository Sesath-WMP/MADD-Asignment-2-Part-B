import Foundation

protocol PersistenceServiceProtocol {
    func loadUserProfile() -> User
    func saveUserProfile(_ user: User)
    func loadHighScore() -> Int
    func saveHighScore(_ score: Int)
}

final class PersistenceService: PersistenceServiceProtocol {
    private let userKey = "cowatch.user"
    private let highScoreKey = "cowatch.highScore"

    func loadUserProfile() -> User {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: userKey),
           let decoded = try? JSONDecoder().decode(User.self, from: data) {
            return decoded
        }
        let fresh = User.placeholderHost
        saveUserProfile(fresh)
        return fresh
    }

    func saveUserProfile(_ user: User) {
        let defaults = UserDefaults.standard
        if let data = try? JSONEncoder().encode(user) {
            defaults.set(data, forKey: userKey)
        }
    }

    func loadHighScore() -> Int {
        UserDefaults.standard.integer(forKey: highScoreKey)
    }

    func saveHighScore(_ score: Int) {
        let defaults = UserDefaults.standard
        let existing = defaults.integer(forKey: highScoreKey)
        if score > existing {
            defaults.set(score, forKey: highScoreKey)
        }
    }
}
