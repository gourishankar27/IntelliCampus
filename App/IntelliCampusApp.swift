//
//  IntelliCampusApp.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import SwiftUI
import FirebaseCore


@main
struct IntelliCampusApp: App {
    init() {
        FirebaseApp.configure()
    }

    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                HomeView()
                    .environmentObject(coordinator)
            }
            .navigationDestination(for: Route.self) { route in
                coordinator.destinationView(for: route)
            }
            
        }
    }
}
