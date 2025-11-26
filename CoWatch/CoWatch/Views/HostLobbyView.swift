import SwiftUI

struct HostLobbyView: View {
    @ObservedObject var viewModel: HostLobbyViewModel
    @EnvironmentObject private var services: ServiceContainer

    @State private var participantsAppeared: Bool = false

    var body: some View {
        ZStack {
            BackgroundWallpaper(style: .generic)

            VStack(alignment: .leading, spacing: 40) {
                Text("Lobby")
                    .font(CoWatchTypography.titleL)
                    .foregroundColor(CoWatchColors.neonLime)

                Text("Content: \(viewModel.session.contentItem?.title ?? "-")")
                    .font(CoWatchTypography.bodyL)
                    .foregroundColor(.white)

                Text("Participants")
                    .font(CoWatchTypography.titleM)
                    .foregroundColor(CoWatchColors.cyanGlow)

                HStack(spacing: 32) {
                    ParticipantChip(name: viewModel.session.host.name, colorHex: viewModel.session.host.avatarColorHex, isHost: true)
                    ForEach(viewModel.peers) { peer in
                        ParticipantChip(name: peer.user.name, colorHex: peer.user.avatarColorHex, isHost: false)
                    }
                }
                .opacity(participantsAppeared ? 1 : 0)
                .offset(y: participantsAppeared ? 0 : 20)
                .animation(.easeOut(duration: 0.4).delay(0.1), value: participantsAppeared)

                HStack(spacing: 40) {
                    if let item = viewModel.session.contentItem {
                        NavigationLink {
                            PlaybackView(viewModel: PlaybackViewModel(services: services, contentItem: item))
                        } label: {
                            FocusableButtonLabel(title: "Start Playback", systemName: "play.circle.fill")
                        }
                    } else {
                        Text("No content")
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        viewModel.endSession()
                    }) {
                        FocusableButtonLabel(title: "End Session", systemName: "xmark.circle")
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 80)
            .padding(.top, 80)
        }
        .onAppear {
            services.simulationService.simulateJoinLobby()
            participantsAppeared = true
        }
    }
}

struct ParticipantChip: View {
    let name: String
    let colorHex: String
    let isHost: Bool

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color(hex: colorHex))
                .frame(width: 64, height: 64)
                .overlay(Circle().stroke(CoWatchColors.cyanGlow, lineWidth: isHost ? 4 : 1))
            Text(name)
                .font(CoWatchTypography.label)
                .foregroundColor(.white)
            if isHost {
                Text("Host")
                    .font(.caption)
                    .foregroundColor(CoWatchColors.neonLime)
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch cleaned.count {
        case 8: // ARGB
            a = (int & 0xFF00_0000) >> 24
            r = (int & 0x00FF_0000) >> 16
            g = (int & 0x0000_FF00) >> 8
            b = int & 0x0000_00FF
        default: // RGB
            a = 255
            r = (int & 0xFF0000) >> 16
            g = (int & 0x00FF00) >> 8
            b = int & 0x0000FF
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
