//
//  HomeViewModel.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
//import SwiftUI


/// ViewModel for `HomeView`, exposing available modules and handling selection.
class HomeViewModel: ObservableObject {
    
    /// A list of all modules to display.
    /// Marked `@Published` so SwiftUI updates the view when this array changes.
    @Published var modules = Module.allCases

    /// Callback invoked when the user selects a module.
    /// Set by the coordinator to drive navigation.
    var onSelect: ((Module) -> Void)?

    /// Called by the view when a module is tapped.
    ///
    /// - Parameter module: The selected `Module`.
    func select(_ module: Module) {
        onSelect?(module)
    }
}

/// Enumeration of app modules shown on the Home screen.
enum Module: String, CaseIterable, Identifiable {
    
    case habit      = "Habit Tracker"
    case tutorials  = "Tutorials"
    // ... other cases can be added here

    /// Conformance to `Identifiable`, using `rawValue` as the unique ID.
    var id: String { rawValue }
}





