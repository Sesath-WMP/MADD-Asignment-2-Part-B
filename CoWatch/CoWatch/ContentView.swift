//
//  ContentView.swift
//  CoWatch
//
//  Created by IM Student on 2025-11-23.
//

import SwiftUI

enum RootRoute {
    case welcome
}

struct RootView: View {
    @EnvironmentObject private var services: ServiceContainer

    var body: some View {
        NavigationStack {
            WelcomeView(viewModel: WelcomeViewModel(services: services))
        }
        .tint(CoWatchColors.neonLime)
        .background(CoWatchColors.darkGraphite)
    }
}
