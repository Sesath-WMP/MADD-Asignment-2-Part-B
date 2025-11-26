import Foundation
import Combine

final class ContentBrowserViewModel: ObservableObject {
    @Published private(set) var items: [ContentItem] = []

    private let services: ServiceContainer

    init(services: ServiceContainer) {
        self.services = services
        load()
    }

    private func load() {
        items = services.contentService.loadContent()
    }
}
