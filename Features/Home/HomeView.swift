//
//  HomeView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import SwiftUI


/// The main dashboard screen listing available IntelliCampus modules.
struct HomeView: View {
    
    /// The view model driving the list of modules and handling user selection.
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        // Display each module in a list; tapping a row notifies via viewModel.select(_:)
        List(viewModel.modules) { module in
            Text(module.rawValue)
                .onTapGesture {
                    viewModel.select(module)
                }
        }
        .navigationTitle("IntelliCampus") // Sets the navigation bar title
    }
}
