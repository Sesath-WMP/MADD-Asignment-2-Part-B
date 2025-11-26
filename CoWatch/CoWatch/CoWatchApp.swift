//
//  CoWatchApp.swift
//  CoWatch
//
//  Created by IM Student on 2025-11-23.
//

import SwiftUI

@main
struct CoWatchApp: App {
    @StateObject private var services = ServiceContainer()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(services)
        }
    }
}
