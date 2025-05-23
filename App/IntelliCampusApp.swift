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
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            if coordinator.isSignedIn {
                NavigationStack(path: $coordinator.path) {
                    HomeView()
                        .environmentObject(coordinator)
                }
                .navigationDestination(for: Route.self) { route in
                    coordinator.destinationView(for: route)
                }
            } else {
                AuthCoordinatorView()
                    .environmentObject(coordinator)
            }
        }
        // Observe when the app goes into the background or becomes inactive:
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background, .inactive:
                // Force sign-out so next launch shows the login flow
                coordinator.signOut()
            default:
                break
            }
        }
    }
}
