//
//  HomeView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import SwiftUI



struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var coordinator: AppCoordinator

    var body: some View {
        List(viewModel.modules, id: \.id) { module in
            Button(module.rawValue) {
                navigate(to: module)
            }
            .buttonStyle(.plain) // so it looks like plain text + tap
        }
        .navigationTitle("IntelliCampus")  // parentheses, not braces
    }

    private func navigate(to module: Module) {
        switch module {
        case .habit:
                coordinator.path.append(Route.habitList)
            case .tutorials:
                coordinator.path.append(Route.tutorialCatalog)
            case .notesCollab:
                coordinator.path.append(Route.notesCollab)
            case .arCampus:
                coordinator.path.append(Route.arCampus)
            case .photoClassifier:
                coordinator.path.append(Route.photoClassifier)
            case .socialFeed:
                coordinator.path.append(Route.socialFeed)
        }

    }
}




