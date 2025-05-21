//
//  AppCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import UIKit


class AppCoordinator: Coordinator {
    private let window: UIWindow
    var navigationController: UINavigationController

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        // Start with Home module
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}
