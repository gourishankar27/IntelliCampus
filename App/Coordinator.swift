//
//  Coordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

//import UIKit
//
///// Defines a navigation unit that can “start” itself.
//protocol Coordinator {
//    /// The navigation controller this flow will push onto.
//    var navigationController: UINavigationController { get set }
//  
//    /// Kick off the flow—e.g. push the initial view controller.
//    func start()
//}

import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype Route: Hashable
    var path: NavigationPath { get set }
    func destinationView(for route: Route) -> AnyView
    func start()
}
