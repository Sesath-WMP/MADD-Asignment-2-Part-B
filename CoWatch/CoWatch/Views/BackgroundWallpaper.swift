import SwiftUI

enum WallpaperStyle {
    case welcome
    case browser
    case playback
    case generic
}

struct BackgroundWallpaper: View {
    let style: WallpaperStyle
    @State private var animate = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: baseColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(radialColor.opacity(0.45))
                .frame(width: 900, height: 900)
                .blur(radius: 120)
                .offset(x: animate ? -260 : 260, y: animate ? -220 : 220)
                .animation(.linear(duration: 26).repeatForever(autoreverses: true), value: animate)

            Circle()
                .fill(secondaryRadial.opacity(0.35))
                .frame(width: 700, height: 700)
                .blur(radius: 90)
                .offset(x: animate ? 320 : -240, y: animate ? 260 : -260)
                .animation(.linear(duration: 30).repeatForever(autoreverses: true), value: animate)
        }
        .onAppear {
            animate = true
        }
    }

    private var baseColors: [Color] {
        switch style {
        case .welcome:
            // Darker, more cinematic gradient for the hero screen
            return [
                Color(red: 0.02, green: 0.02, blue: 0.06),
                Color(red: 0.02, green: 0.10, blue: 0.16)
            ]
        case .browser:
            return [CoWatchColors.darkGraphite, CoWatchColors.cyanGlow.opacity(0.25)]
        case .playback:
            return [CoWatchColors.darkGraphite, CoWatchColors.neonLime.opacity(0.18)]
        case .generic:
            return [CoWatchColors.darkGraphite, CoWatchColors.deepGreen.opacity(0.6)]
        }
    }

    private var radialColor: Color {
        switch style {
        case .welcome:
            return CoWatchColors.neonLime
        case .browser:
            return CoWatchColors.cyanGlow
        case .playback:
            return CoWatchColors.neonLime
        case .generic:
            return CoWatchColors.cyanGlow
        }
    }

    private var secondaryRadial: Color {
        switch style {
        case .welcome:
            return CoWatchColors.amberHighlight
        case .browser:
            return CoWatchColors.neonLime
        case .playback:
            return CoWatchColors.amberHighlight
        case .generic:
            return CoWatchColors.amberHighlight
        }
    }
}
