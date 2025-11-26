import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        ZStack {
            CoWatchColors.darkGraphite.ignoresSafeArea()

            VStack(spacing: 32) {
                Text("Profile & Settings")
                    .font(CoWatchTypography.titleL)
                    .foregroundColor(CoWatchColors.neonLime)

                HStack(spacing: 40) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Name")
                            .font(CoWatchTypography.label)
                            .foregroundColor(.white)
                        TextField("Your name", text: $viewModel.user.name)
                            .padding(12)
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(16)
                            .frame(width: 420)
                    }

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Avatar Color Hex")
                            .font(CoWatchTypography.label)
                            .foregroundColor(.white)
                        TextField("#66FFCC", text: $viewModel.user.avatarColorHex)
                            .padding(12)
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(16)
                            .frame(width: 260)
                    }
                }

                Text("High Score: \(viewModel.highScore)")
                    .font(CoWatchTypography.bodyL)
                    .foregroundColor(CoWatchColors.neonLime)

                Button(action: {
                    viewModel.save()
                }) {
                    FocusableButtonLabel(title: "Save", systemName: "checkmark.circle")
                }

                Spacer()
            }
            .padding(.horizontal, 80)
            .padding(.top, 80)
        }
    }
}
