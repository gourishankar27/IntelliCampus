//
//  AuthCoordinatorView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/22/25.
//

import Foundation
import SwiftUI

struct AuthCoordinatorView: View {
    @StateObject private var authCoord = AuthCoordinator()
    var body: some View {
        NavigationStack(path: $authCoord.path) {
            // 1) Always show the login screen first
            authCoord.destinationView(for: .login)
              .environmentObject(authCoord)

            // 2) Then handle any deeper routes
            .navigationDestination(for: AuthCoordinator.AuthRoute.self) { route in
              authCoord
                .destinationView(for: route)
                .environmentObject(authCoord)
            }
        }
        .onAppear { authCoord.start() }
    }
}
