//
//  HomeCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import SwiftUI

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vm = HomeViewModel()
        let view = HomeView(viewModel: vm)
        vm.onSelect = { [weak self] module in
            switch module {
            case .habit: self?.showHabitTracker()
            case .tutorials: self?.showTutorials()
            default: break
            }
        }
        let host = UIHostingController(rootView: view)
        navigationController.setViewControllers([host], animated: false)
    }

    private func showHabitTracker() {
        let coord = HabitListCoordinator(navigationController: navigationController)
        childCoordinators.append(coord)
        coord.start()
    }

    private func showTutorials() {
        let coord = TutorialsCoordinator(navigationController: navigationController)
        childCoordinators.append(coord)
        coord.start()
    }
}
