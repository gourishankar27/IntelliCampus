//
//  SignupView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/21/25.
//

import Foundation

// Features/Auth/SignupView.swift

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: AuthViewModel
    @EnvironmentObject private var authCoordinator: AuthCoordinator

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Create Account")
                .font(.title2)
                .bold()

            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .textContentType(.newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Sign Up") {
                viewModel.email = email
                viewModel.password = password
                viewModel.signUp()    // implement in AuthViewModel
            }
            .buttonStyle(.borderedProminent)

            Button("Back to Login") {
                authCoordinator.path.removeLast()  // pop back to login
            }
            .buttonStyle(.plain)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.top)
            }
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}
