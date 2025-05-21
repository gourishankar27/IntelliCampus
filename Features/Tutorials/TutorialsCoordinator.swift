//
//  TutorialsCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import UIKit
import SwiftUI
import StoreKit

class TutorialsCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let service: TutorialServiceProtocol = TutorialService()
        let viewModel = TutorialCatalogViewModel(service: service)
        
        // Explicitly capture self to avoid implicit capture of navigationController
        let view = TutorialCatalogView(viewModel: viewModel) { [weak self] tutorial in
            guard let self = self else { return }
            let detailCoordinator = TutorialDetailCoordinator(
                navigationController: self.navigationController,
                tutorial: tutorial
            )
            detailCoordinator.start()
        }

        let host = UIHostingController(rootView: view)
        navigationController.pushViewController(host, animated: true)
    }
}
