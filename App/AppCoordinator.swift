//
//  AppCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation

import SwiftUI
import Combine

/// The central coordinator for all app-wide navigation.
final class AppCoordinator: ObservableObject {
    /// The stack of navigation routes
    @Published var path = NavigationPath()
    @Published var isSignedIn = false
    
    private var cancellables = Set<AnyCancellable>()
    private let auth: AuthServiceProtocol
    
    
    
//    /// Seed the navigation with the Home screen
//    func start() {
//        path.append(Route.home)
//    }
    

    init(authService: AuthServiceProtocol = AuthService()) {
        self.auth = authService

        // Drive both the isSignedIn flag *and* the initial path
        auth.currentUserPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] user in
                guard let self = self else { return }
                self.isSignedIn = (user != nil)

                // reset stack & seed appropriate route
                self.path = NavigationPath()
                self.path.append(user == nil ? Route.login : Route.home)
            }
            .store(in: &cancellables)
    }
    
    
    /// Sign the user out immediately.
    func signOut() {
        // For simplicity ignore errors here
        _ = auth.signOut()
            .sink { _ in } receiveValue: { }
    }
    
    /// Returns the view for a given Route
    @ViewBuilder
    func destinationView(for route: Route) -> some View {
        switch route {
            
            case .login:
                AuthCoordinatorView()
            case .signup:
                  SignupView(viewModel: AuthViewModel(service: auth))
            
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
            
            case .tutorialDetail(let tutorial):
                let vm = TutorialDetailViewModel(service: TutorialService(), tutorial: tutorial)
                TutorialDetailView(viewModel: vm)
            
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

