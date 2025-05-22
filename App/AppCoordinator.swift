//
//  AppCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
//import UIKit
//
//
//class AppCoordinator: Coordinator {
//    private let window: UIWindow
//    var navigationController: UINavigationController
//
//    init(window: UIWindow, navigationController: UINavigationController) {
//        self.window = window
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        // Start our very first module — Start with Home module
//        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
//        homeCoordinator.start()
//    }
//}


// App/AppCoordinator.swift

import SwiftUI
import Combine

/// The central coordinator for all app-wide navigation.
final class AppCoordinator: ObservableObject {
    /// The stack of navigation routes
    @Published var path = NavigationPath()
    
    /// Seed the navigation with the Home screen
    func start() {
        path.append(Route.home)
    }
    
    /// Returns the view for a given Route
    @ViewBuilder
    func destinationView(for route: Route) -> some View {
        switch route {
        
        case .home:
            HomeView()
                .environmentObject(self)
            
        case .habitList:
            // Habit Tracker flow
            let vm = HabitListViewModel(service: HabitService())
            HabitListView(viewModel: vm)
        
        case .tutorialCatalog:
                let vm = TutorialCatalogViewModel(service: TutorialService())
                TutorialCatalogView(viewModel: vm)
                    .environmentObject(self)
        
        case .tutorialDetail(let id):
                // Instantiate your service once
                let service = TutorialService()
                // Pull all tutorials
                let all = service.getAllTutorials()
                
                Group {
                    if let tutorial = all.first(where: { $0.id == id }) {
                        TutorialDetailView(
                            viewModel: TutorialDetailViewModel(
                                service: service,
                                tutorial: tutorial
                            )
                        )
                    }else {
                        // Not found → fallback text
                        Text("Tutorial not found")
                            .foregroundColor(.secondary)
                            .italic()
                    }
                }
        
//        case .notesCollab:
//            // Real-time Collaborative Notes
//            let vm = NotesCollabViewModel(service: NotesService())
//            NotesCollabView(viewModel: vm)
//        
//        case .arCampus:
//            // AR-powered Campus Navigator
//            let vm = ARCampusViewModel(service: ARService())
//            ARCampusView(viewModel: vm)
//        
//        case .photoClassifier:
//            // On-device ML Photo Classifier
//            let vm = PhotoClassifierViewModel(service: MLService())
//            PhotoClassifierView(viewModel: vm)
//        
//        case .socialFeed:
//            // Location-Aware Social Feed
//            let vm = SocialFeedViewModel(service: SocialService())
//            SocialFeedView(viewModel: vm)
            
        @unknown default:
                // Fallback for unhandled routes
                Text("Not implemented yet")
                    .foregroundColor(.secondary)
                    .italic()
        
        }
    }
}

