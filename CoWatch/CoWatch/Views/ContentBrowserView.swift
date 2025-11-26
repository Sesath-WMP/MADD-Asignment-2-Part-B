import SwiftUI

struct ContentBrowserView: View {
    @ObservedObject var viewModel: ContentBrowserViewModel
    @EnvironmentObject private var services: ServiceContainer

    private let columns = [GridItem(.adaptive(minimum: 380), spacing: 40)]

    @State private var appeared: Bool = false

    var body: some View {
        ZStack {
            BackgroundWallpaper(style: .browser)

            VStack(alignment: .leading, spacing: 32) {
                Text("Choose something to watch")
                    .font(CoWatchTypography.titleL)
                    .foregroundColor(.white)

                ScrollView(.horizontal) {
                    LazyHGrid(rows: columns, spacing: 40) {
                        ForEach(viewModel.items) { item in
                            NavigationLink {
                                HostLobbyView(viewModel: HostLobbyViewModel(services: services, host: services.persistenceService.loadUserProfile(), contentItem: item))
                            } label: {
                                ContentCardView(item: item)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }

                Spacer()
            }
            .padding(.horizontal, 80)
            .padding(.top, 80)
            .opacity(appeared ? 1 : 0)
            .scaleEffect(appeared ? 1 : 0.96)
            .animation(.easeOut(duration: 0.45), value: appeared)
        }
        .onAppear {
            appeared = true
        }
    }
}

struct ContentCardView: View {
    let item: ContentItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .bottomLeading) {
                ZStack {
                    // Base gradient or thumbnail imagery
                    Image(item.thumbnailName)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.9)
                        .clipped()

                    // Fallback symbolic artwork so cards are never visually empty
                    LinearGradient(
                        colors: [Color.black.opacity(0.0), Color.black.opacity(0.65)],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: iconName)
                                .font(.system(size: 40, weight: .semibold))
                                .foregroundColor(CoWatchColors.cyanGlow.opacity(0.9))
                            Spacer()
                        }
                        .padding([.leading, .bottom], 24)
                    }
                }
                .frame(width: 420, height: 240)
                .background(
                    LinearGradient(colors: [CoWatchColors.deepGreen, CoWatchColors.darkGraphite], startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(28)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(CoWatchColors.cyanGlow.opacity(0.5), lineWidth: 1)
                )

                Text(item.title)
                    .font(CoWatchTypography.titleM)
                    .foregroundColor(.white)
                    .padding(24)
            }

            Text(item.description)
                .font(CoWatchTypography.bodyM)
                .foregroundColor(.white.opacity(0.7))
                .lineLimit(2)
        }
    }

    private var iconName: String {
        let title = item.title.lowercased()
        if title.contains("nature") { return "leaf.fill" }
        if title.contains("city") { return "building.2.fill" }
        if title.contains("ocean") { return "water.waves" }
        if title.contains("arcade") { return "gamecontroller.fill" }
        if title.contains("skyline") { return "sunset.fill" }
        if title.contains("cosmic") { return "sparkles" }
        return "play.rectangle.fill"
    }
}
