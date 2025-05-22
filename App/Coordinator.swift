//
//  Coordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import UIKit

/// Defines a navigation unit that can “start” itself.
protocol Coordinator {
    /// The navigation controller this flow will push onto.
    var navigationController: UINavigationController { get set }
  
    /// Kick off the flow—e.g. push the initial view controller.
    func start()
}

