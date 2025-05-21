//
//  Coordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import UIKit

/// Defines a navigation unit that can “start” itself.
protocol Coordinator {
  var navigationController: UINavigationController { get set }
  func start()
}

