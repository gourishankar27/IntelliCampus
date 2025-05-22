//
//  AppDelegate.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Create the main window and a UINavigationController
        let window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()

        // Bootstrap AppCoordinator
        coordinator = AppCoordinator(window: window, navigationController: nav)
        
        /// Attach nav controller as root and show it
        window.rootViewController = nav
        window.makeKeyAndVisible()

        /// Kick off our first flow
        coordinator?.start()

        self.window = window
        return true
    }
}
