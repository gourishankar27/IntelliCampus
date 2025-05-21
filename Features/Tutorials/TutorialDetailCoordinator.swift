//
//  TutorialDetailCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import UIKit
import SwiftUI

class TutorialDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let tutorial: Tutorial

    init(navigationController: UINavigationController, tutorial: Tutorial) {
        self.navigationController = navigationController
        self.tutorial = tutorial
    }

    func start() {
        let service: TutorialServiceProtocol = TutorialService()
        let viewModel = TutorialDetailViewModel(service: service, tutorial: tutorial)
        let view = TutorialDetailView(viewModel: viewModel)
        let host = UIHostingController(rootView: view)
        navigationController.pushViewController(host, animated: true)
    }
}
