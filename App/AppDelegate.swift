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
        // Create window & nav controller
        let window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()

        // Bootstrap AppCoordinator
        coordinator = AppCoordinator(window: window, navigationController: nav)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        coordinator?.start()

        self.window = window
        return true
    }
}
