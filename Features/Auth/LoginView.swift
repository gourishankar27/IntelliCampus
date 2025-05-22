//
//  LoginView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/21/25.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject private var authCoordinator: AuthCoordinator

  var body: some View {
    VStack(spacing: 20) {
        TextField("Email", text: $viewModel.email)
        SecureField("Password", text: $viewModel.password)
            
        Button("Sign Up") {
                       // 2️⃣ Fully‐qualify the signup route
            authCoordinator.path.append(AuthCoordinator.AuthRoute.signup)
                   }
                   .buttonStyle(.plain)
      
        SignInWithAppleButton(
                        .signIn,                                   // or .continue
                        onRequest: { request in
                            // If you need to set up a nonce, you can do it here:
                            // viewModel.prepareAppleRequest(request)
                        },
                        onCompletion: { result in
                            // When the Apple flow completes, trigger your viewModel
                            viewModel.signInWithApple()
                        }
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 44)
        
        
        Button("Google") {
                        // 1) Grab the key window’s rootViewController as the presenter
                        guard let rootVC = UIApplication.shared.connectedScenes
                                .compactMap({ $0 as? UIWindowScene })
                                .flatMap({ $0.windows })
                                .first(where: { $0.isKeyWindow })?
                                .rootViewController
                        else { return }

                        // 2) Call your ViewModel’s method (which subscribes under the hood)
                        viewModel.signInWithGoogle(presenting: rootVC)
                    }
                    .buttonStyle(.borderedProminent)
        
        
        if let err = viewModel.errorMessage {
            Text(err).foregroundColor(.red)
        }
    }
    .padding()
    .navigationTitle("Login")
  }
}
