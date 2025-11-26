import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: WelcomeViewModel
    @EnvironmentObject private var services: ServiceContainer

    @State private var appeared: Bool = false

    var body: some View {
        ZStack {
            BackgroundWallpaper(style: .welcome)

            VStack(spacing: 32) {
                // Hero
                VStack(spacing: 8) {
                    Text("CoWatch")
                        .font(CoWatchTypography.titleXL)
                        .foregroundColor(.white)
                        .shadow(radius: 18)

                    Text("Watch together. Play together.")
                        .font(CoWatchTypography.bodyM)
                        .foregroundColor(.white.opacity(0.75))
                }

                // Primary actions
                HStack(spacing: 32) {
                    NavigationLink {
                        ContentBrowserView(viewModel: ContentBrowserViewModel(services: services))
                    } label: {
                        FocusableButtonLabel(title: "Host Session", systemName: "display.tv")
                    }

                    NavigationLink {
                        ContentBrowserView(viewModel: ContentBrowserViewModel(services: services))
                    } label: {
                        FocusableButtonLabel(title: "Join Session", systemName: "person.2.fill")
                    }
                }
                // Simulation controls card
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Text("Simulation")
                            .font(CoWatchTypography.titleM)
                            .foregroundColor(.white)
                        Spacer()
                        Toggle(isOn: $viewModel.isSimulationMode) {
                            Text(viewModel.isSimulationMode ? "On" : "Off")
                                .font(CoWatchTypography.label)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .labelsHidden()
                        .toggleStyle(.switch)
                    }

                    HStack(spacing: 32) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Peers")
                                .font(CoWatchTypography.label)
                                .foregroundColor(.white.opacity(0.7))
                            HStack(spacing: 10) {
                                ForEach(1...3, id: \.self) { count in
                                    Circle()
                                        .fill(count <= viewModel.simulatedPeerCount ? CoWatchColors.cyanGlow : Color.white.opacity(0.15))
                                        .frame(width: 26, height: 26)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                        )
                                        .onTapGesture {
                                            viewModel.simulatedPeerCount = count
                                        }
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Latency")
                                .font(CoWatchTypography.label)
                                .foregroundColor(.white.opacity(0.7))
                            HStack(spacing: 12) {
                                Text(String(format: "%.1f s", viewModel.simulatedLatency))
                                    .font(CoWatchTypography.bodyM)
                                    .foregroundColor(.white)
                                HStack(spacing: 6) {
                                    Button(action: {
                                        viewModel.simulatedLatency = max(0.2, (viewModel.simulatedLatency - 0.1).rounded(toPlaces: 1))
                                    }) {
                                        Image(systemName: "minus")
                                            .font(.system(size: 18, weight: .semibold))
                                            .padding(8)
                                    }
                                    .buttonStyle(.borderedProminent)

                                    Button(action: {
                                        viewModel.simulatedLatency = min(1.2, (viewModel.simulatedLatency + 0.1).rounded(toPlaces: 1))
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 18, weight: .semibold))
                                            .padding(8)
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 24)
                .frame(maxWidth: 720)
                .background(Color.black.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.white.opacity(0.18), lineWidth: 1)
                )
                .cornerRadius(28)
                .onChange(of: viewModel.simulatedPeerCount) { _, _ in
                    viewModel.configureSimulation()
                }
                .onChange(of: viewModel.simulatedLatency) { _, _ in
                    viewModel.configureSimulation()
                }
                .onAppear {
                    viewModel.configureSimulation()
                }

                Spacer()

                NavigationLink {
                    ProfileView(viewModel: ProfileViewModel(services: services))
                } label: {
                    Text("Profile & Settings")
                        .font(CoWatchTypography.label)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(18)
                }
            }
            .padding(.top, 120)
            .padding(.horizontal, 80)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 40)
            .animation(.easeOut(duration: 0.5), value: appeared)
        }
        .onAppear {
            appeared = true
        }
    }
}

private extension Double {
    func rounded(toPlaces places: Int) -> Double {
        guard places >= 0 else { return self }
        let factor = pow(10.0, Double(places))
        return (self * factor).rounded() / factor
    }
}

struct FocusableButtonLabel: View {
    let title: String
    let systemName: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: systemName)
                .font(.system(size: 40, weight: .semibold))
            Text(title)
                .font(CoWatchTypography.bodyM)
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 14)
        .frame(width: 230)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [CoWatchColors.deepGreen.opacity(0.9), CoWatchColors.cyanGlow.opacity(0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(Color.white.opacity(0.16), lineWidth: 1)
        )
        .foregroundColor(.white)
    }
}
