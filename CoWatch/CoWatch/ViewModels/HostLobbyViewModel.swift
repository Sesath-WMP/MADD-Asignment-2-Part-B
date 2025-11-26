import Foundation
import Combine

final class HostLobbyViewModel: ObservableObject {
    @Published private(set) var session: Session
    @Published private(set) var peers: [SimulatedPeer] = []

    private let services: ServiceContainer

    init(services: ServiceContainer, host: User, contentItem: ContentItem) {
        self.services = services
        self.session = Session(host: host, participants: [], contentItem: contentItem)

        services.simulationService.onPeersChanged = { [weak self] peers in
            self?.peers = peers
        }
        services.simulationService.simulateJoinLobby()
    }

    func startPlayback() {
        session.state = .playing
    }

    func endSession() {
        session.state = .finished
    }
}
