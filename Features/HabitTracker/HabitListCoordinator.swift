//
//  HabitListCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import UIKit
import SwiftUI

class HabitListCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let service: HabitServiceProtocol = HabitService()
        let viewModel = HabitListViewModel(service: service)
        let view = HabitListView(viewModel: viewModel)
        let host = UIHostingController(rootView: view)
        navigationController.pushViewController(host, animated: true)
    }
}
