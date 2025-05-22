//
//  HomeViewModel.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation

/// Pure ViewModel: just holds the module list
final class HomeViewModel: ObservableObject {
    /// Static list of all feature modules
    let modules: [Module] = Module.allCases
}
