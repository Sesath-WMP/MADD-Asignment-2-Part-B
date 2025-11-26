import Foundation
import Combine

final class WelcomeViewModel: ObservableObject {
    @Published var isSimulationMode: Bool = true
    @Published var simulatedPeerCount: Int = 2
    @Published var simulatedLatency: Double = 0.6

    private let services: ServiceContainer

    init(services: ServiceContainer) {
        self.services = services
    }

    func configureSimulation() {
        services.simulationService.configure(peerCount: simulatedPeerCount, baseLatency: simulatedLatency)
    }
}
