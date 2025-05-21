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


@main
struct IntelliCampusApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            EmptyView() // UIKit handles root via AppDelegate & AppCoordinator
        }
    }
}

