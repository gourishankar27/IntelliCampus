//
//  HomeCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

// HomeCoordinator.swift

import Foundation
import SwiftUI

/// Manages navigation for the Home screen and its sub-flows.
class HomeCoordinator: Coordinator {
    
    /// The UINavigationController this coordinator will push onto.
    var navigationController: UINavigationController
    
    /// Keeps strong references to any child coordinators to prevent them
    /// from being deallocated mid-flow.
    private var childCoordinators: [Coordinator] = []

    /// Initialize with the app's root navigation controller.
    ///
    /// - Parameter navigationController: The shared UINavigationController
    ///   used by all coordinators in this flow.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts the Home flow by presenting the HomeView wrapped in a
    /// UIHostingController.
    ///
    /// Sets up the HomeViewModel’s `onSelect` callback so that user taps
    /// trigger the correct sub-coordinator.
    func start() {
        // 1️⃣ Create and configure the view model
        let vm = HomeViewModel()
        
        // 2️⃣ Define what happens when the user selects a module
        vm.onSelect = { [weak self] module in
            switch module {
            case .habit:
                self?.showHabitTracker()
            case .tutorials:
                self?.showTutorials()
            default:
                break
            }
        }
        
        // 3️⃣ Create the SwiftUI view and embed in a hosting controller
        let view = HomeView(viewModel: vm)
        let host = UIHostingController(rootView: view)
        
        // 4️⃣ Replace the nav stack’s root with the Home screen
        navigationController.setViewControllers([host], animated: false)
    }

    // MARK: - Child Flows

    /// Bootstraps and starts the Habit Tracker flow.
    private func showHabitTracker() {
        let coord = HabitListCoordinator(navigationController: navigationController)
        childCoordinators.append(coord)  // keep a strong ref
        coord.start()
    }

    /// Bootstraps and starts the Tutorials flow.
    private func showTutorials() {
        let coord = TutorialsCoordinator(navigationController: navigationController)
        childCoordinators.append(coord)  // keep a strong ref
        coord.start()
    }
}

