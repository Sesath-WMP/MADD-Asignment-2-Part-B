import SwiftUI

enum CoWatchColors {
    static let deepGreen = Color(red: 0.03, green: 0.20, blue: 0.20) // darker teal base
    static let neonLime = Color(red: 0.55, green: 0.85, blue: 1.0)   // cool electric blue accent
    static let cyanGlow = Color(red: 0.35, green: 0.95, blue: 0.95)  // softer cyan glow
    static let darkGraphite = Color(red: 0.05, green: 0.06, blue: 0.08) // deeper background
    static let amberHighlight = Color(red: 0.78, green: 0.60, blue: 1.0)  // neon violet highlight
}

extension View {
    func neonFocusGlow(isFocused: Bool) -> some View {
        self
            .scaleEffect(isFocused ? 1.05 : 1.0)
            .shadow(color: CoWatchColors.cyanGlow.opacity(isFocused ? 0.9 : 0.0), radius: isFocused ? 25 : 0, x: 0, y: 0)
            .shadow(color: CoWatchColors.neonLime.opacity(isFocused ? 0.5 : 0.0), radius: isFocused ? 40 : 0, x: 0, y: 0)
            .animation(.easeOut(duration: 0.22), value: isFocused)
    }
}
