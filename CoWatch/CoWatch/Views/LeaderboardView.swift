import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var viewModel: LeaderboardViewModel

    var body: some View {
        ZStack {
            CoWatchColors.darkGraphite.ignoresSafeArea()

            VStack(spacing: 40) {
                Text("Leaderboard")
                    .font(CoWatchTypography.titleXL)
                    .foregroundColor(CoWatchColors.neonLime)

                if viewModel.users.count >= 1 {
                    PodiumView(users: Array(viewModel.users.prefix(3)))
                }

                ListView(users: viewModel.users)

                Spacer()
            }
            .padding(.top, 80)
        }
    }
}

struct PodiumView: View {
    let users: [User]

    var body: some View {
        HStack(alignment: .bottom, spacing: 60) {
            ForEach(Array(users.enumerated()), id: \.1.id) { index, user in
                VStack(spacing: 8) {
                    Text(user.name)
                        .font(CoWatchTypography.bodyM)
                        .foregroundColor(.white)
                    Text("\(user.totalScore)")
                        .font(CoWatchTypography.titleM)
                        .foregroundColor(CoWatchColors.neonLime)
                    Rectangle()
                        .fill(LinearGradient(colors: [CoWatchColors.cyanGlow, CoWatchColors.deepGreen], startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: CGFloat(120 + (2 - index) * 40))
                        .cornerRadius(16)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(response: 0.6, dampingFraction: 0.7), value: users)
            }
        }
    }
}

struct ListView: View {
    let users: [User]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(users.enumerated()), id: \.1.id) { index, user in
                HStack {
                    Text("#\(index + 1)")
                        .frame(width: 60, alignment: .leading)
                    Text(user.name)
                        .frame(width: 260, alignment: .leading)
                    Spacer()
                    Text("\(user.totalScore) pts")
                }
                .font(CoWatchTypography.bodyM)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 8)
                .background(Color.white.opacity(index % 2 == 0 ? 0.04 : 0.02))
                .cornerRadius(16)
            }
        }
        .padding(.horizontal, 120)
    }
}
