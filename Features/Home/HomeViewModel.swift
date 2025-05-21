//
//  HomeViewModel.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
//import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var modules = Module.allCases
    var onSelect: ((Module) -> Void)?
    func select(_ module: Module) { onSelect?(module) }
}

enum Module: String, CaseIterable, Identifiable {
    case habit = "Habit Tracker"
    case tutorials = "Tutorials"
    // ... other cases
    var id: String { rawValue }
}


