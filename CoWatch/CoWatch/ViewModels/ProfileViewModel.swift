import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published private(set) var highScore: Int

    private let services: ServiceContainer

    init(services: ServiceContainer) {
        self.services = services
        self.user = services.persistenceService.loadUserProfile()
        self.highScore = services.persistenceService.loadHighScore()
    }

    func save() {
        services.persistenceService.saveUserProfile(user)
        services.persistenceService.saveHighScore(highScore)
    }
}
