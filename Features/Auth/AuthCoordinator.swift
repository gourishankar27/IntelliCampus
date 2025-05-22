//
//  AuthCoordinator.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/21/25.
//

import Foundation
import SwiftUI
import Combine

/// Coordinates the Login/Signup flow.
final class AuthCoordinator: ObservableObject {
    /// The stack of auth routes (login → signup).
    @Published var path = NavigationPath()

    /// The auth service (Sign in with Apple/Google/email+pw).
    private let authService: AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    /// Inject your AuthService for testability.
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }

    /// Kick off the flow by showing the login screen.
    func start() {
        // Reset the stack by creating a fresh NavigationPath
        path = NavigationPath()
        // Then seed it with the login route
        path.append(AuthRoute.login)
    }

    /// All the screens in the auth flow.
    enum AuthRoute: Hashable {
        case login
        case signup
    }

    /// Map each AuthRoute to its SwiftUI view.
    @ViewBuilder
    func destinationView(for route: AuthRoute) -> some View {
        switch route {
        case .login:
            // Login screen
            LoginView(viewModel: AuthViewModel(service: authService))
                .environmentObject(self)

        case .signup:
            // Email/password signup
            SignupView(viewModel: AuthViewModel(service: authService))
                .environmentObject(self)
        }
    }
}
