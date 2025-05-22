//
//  IntelliCampusApp.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import SwiftUI

//@main
//struct IntelliCampusApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}


//@main
//struct IntelliCampusApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//    var body: some Scene {
//        WindowGroup {
//            EmptyView() // UIKit handles root via AppDelegate & AppCoordinator
//        }
//    }
//}

@main
struct IntelliCampusApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                // The very first view is HomeView()
                HomeView()
                    .environmentObject(coordinator)
                
                    // 2) Register every Route → View mapping:
                    .navigationDestination(for: Route.self) { route in
                        
                        // This closure is called whenever you do:
                        //   coordinator.path.append(someRoute)
                        coordinator.destinationView(for: route)
                    }
            }
            .onAppear { coordinator.start() }
        }
    }
}
