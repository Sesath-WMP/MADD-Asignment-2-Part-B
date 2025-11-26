import SwiftUI
import AVKit

struct PlaybackView: View {
    @ObservedObject var viewModel: PlaybackViewModel
    @EnvironmentObject private var services: ServiceContainer
    @State private var navigateToLeaderboard = false

    var body: some View {
        ZStack {
            BackgroundWallpaper(style: .playback)

            VStack(spacing: 28) {
                // Title
                Text(viewModel.contentItem.title)
                    .font(CoWatchTypography.titleL)
                    .foregroundColor(.white)
                    .shadow(radius: 12)

                // Video frame
                VideoPlayer(player: viewModel.player)
                    .aspectRatio(16.0 / 9.0, contentMode: .fit)
                    .frame(maxWidth: 1100)
                    .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 26, style: .continuous)
                            .stroke(CoWatchColors.cyanGlow.opacity(0.5), lineWidth: 1.5)
                    )
                    .shadow(color: Color.black.opacity(0.8), radius: 30, x: 0, y: 18)

                // Controls row
                HStack(spacing: 32) {
                    PlaybackControlButton(title: "Play", systemName: "play.fill") {
                        viewModel.hostPlay()
                    }

                    PlaybackControlButton(title: "Pause", systemName: "pause.fill") {
                        viewModel.hostPause()
                    }

                    PlaybackControlButton(title: "End & Leaderboard", systemName: "list.number") {
                        navigateToLeaderboard = true
                    }
                }

                // Score
                Text("Your score: \(viewModel.userScore)")
                    .font(CoWatchTypography.bodyM)
                    .foregroundColor(CoWatchColors.neonLime)
                    .padding(.top, 8)
            }
            .padding(.horizontal, 80)
            .padding(.top, 60)
            .transition(.opacity.combined(with: .move(edge: .bottom)))
            .allowsHitTesting(!viewModel.isQuizPresented)
            .disabled(viewModel.isQuizPresented)

            if viewModel.isQuizPresented, let quiz = viewModel.activeQuiz {
                QuizOverlay(quiz: quiz) { index in
                    viewModel.submitAnswer(index: index)
                }
            }
        }
        .navigationDestination(isPresented: $navigateToLeaderboard) {
            LeaderboardView(viewModel: LeaderboardViewModel(users: viewModel.leaderboardUsers))
        }
        .onAppear {
            if let url = URL(string: viewModel.contentItem.videoFileName) {
                viewModel.player.replaceCurrentItem(with: AVPlayerItem(url: url))
            }
        }
    }
}

private struct PlaybackControlButton: View {
    let title: String
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: systemName)
                    .font(.system(size: 30, weight: .semibold))
                Text(title)
                    .font(CoWatchTypography.bodyM)
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(LinearGradient(
                        colors: [CoWatchColors.deepGreen.opacity(0.95), CoWatchColors.cyanGlow.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.6), radius: 12, x: 0, y: 10)
            .foregroundColor(.white)
        }
        .buttonStyle(.plain)
    }
}
