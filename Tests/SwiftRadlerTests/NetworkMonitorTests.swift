import Testing
@testable import SwiftRadler

@Suite("NetworkMonitor Tests")
struct NetworkMonitorTests {
    @Test("Defaults before any path updates")
    func defaultsBeforeUpdates() async throws {
        let monitor = NetworkMonitor()
        // Before any NWPath updates arrive, isConnected should default to true
        // and isExpensive should default to false.
        #expect(monitor.isConnected == true)
        #expect(monitor.isExpensive == false)
    }
}
