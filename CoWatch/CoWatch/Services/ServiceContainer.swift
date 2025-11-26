import Foundation
import Combine

final class ServiceContainer: ObservableObject {
    let contentService: ContentServiceProtocol
    let playbackSyncService: PlaybackSyncServiceProtocol
    let simulationService: SimulationServiceProtocol
    let persistenceService: PersistenceServiceProtocol

    init(
        contentService: ContentServiceProtocol = ContentService(),
        playbackSyncService: PlaybackSyncServiceProtocol = PlaybackSyncService(),
        simulationService: SimulationServiceProtocol = SimulationService(),
        persistenceService: PersistenceServiceProtocol = PersistenceService()
    ) {
        self.contentService = contentService
        self.playbackSyncService = playbackSyncService
        self.simulationService = simulationService
        self.persistenceService = persistenceService
    }
}
