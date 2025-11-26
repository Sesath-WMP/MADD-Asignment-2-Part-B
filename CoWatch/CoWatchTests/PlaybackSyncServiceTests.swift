import XCTest
@testable import CoWatch

final class PlaybackSyncServiceTests: XCTestCase {
    func testApplySyncDoesNotCrashWhenNoPlayer() {
        let service = PlaybackSyncService()
        service.applySync(targetTime: 10, latency: 0.5)
        // If we reach here without a crash, behavior is acceptable for prototype
    }
}
