//
//  AuthViewModel.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/21/25.
//

import Foundation
import SwiftUI
import Combine

final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?

    private let service: AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: AuthServiceProtocol) {
    self.service = service
    }

    func signIn() {
    service.signIn(email: email, password: password)
      .sink { comp in
        if case .failure(let err) = comp {
          self.errorMessage = err.localizedDescription
        }
      } receiveValue: {}
      .store(in: &cancellables)
    }

    func signInWithApple() {
    service.signInWithApple()
      .sink { comp in
        if case .failure(let err) = comp {
          self.errorMessage = err.localizedDescription
        }
      } receiveValue: {}
      .store(in: &cancellables)
    }

    func signInWithGoogle(presenting: UIViewController) {
    service.signInWithGoogle(presenting: presenting)
      .sink { comp in
        if case .failure(let err) = comp {
          self.errorMessage = err.localizedDescription
        }
      } receiveValue: {}
      .store(in: &cancellables)
    }

    func signUp() {
        service.signUp(email: email, password: password)
            .sink { completion in
                if case .failure(let err) = completion {
                    self.errorMessage = err.localizedDescription
                }
            } receiveValue: { }
            .store(in: &cancellables)
    }
}

