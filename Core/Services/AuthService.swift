//
//  AuthService.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/21/25.
//

// Core/Services/AuthService.swift

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import AuthenticationServices
import Combine
import UIKit


import CryptoKit

func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashed = SHA256.hash(data: inputData)
  return hashed.compactMap { String(format: "%02x", $0) }.joined()
}

/// Errors specific to our AuthService
enum AuthError: LocalizedError {
    case missingClientID
    case googleAuthenticationFailed
    case appleAuthenticationFailed

    var errorDescription: String? {
        switch self {
        case .missingClientID:            return "Missing Firebase client ID."
        case .googleAuthenticationFailed: return "Google authentication failed."
        case .appleAuthenticationFailed:  return "Apple authentication failed."
        }
    }
}

/// Protocol for all auth operations
protocol AuthServiceProtocol {
    /// The currently signed-in Firebase user (nil if signed out)
    var currentUser: User? { get }

    /// Emits whenever the auth state changes
    var currentUserPublisher: AnyPublisher<User?, Never> { get }

    func signUp(email: String, password: String) -> AnyPublisher<Void, Error>
    func signIn(email: String, password: String) -> AnyPublisher<Void, Error>
    func signInWithApple() -> AnyPublisher<Void, Error>
    func signInWithGoogle(presenting: UIViewController) -> AnyPublisher<Void, Error>
    func signOut() -> AnyPublisher<Void, Error>
}

/// Concrete implementation backed by FirebaseAuth
final class AuthService: NSObject, AuthServiceProtocol {
    private let auth = Auth.auth()
    
    /// Now publishes your domain User?
    private let userSubject = CurrentValueSubject<User?, Never>(nil)
    
    private var appleSignInPromise: ((Result<Void, Error>) -> Void)?
    
    private var currentNonce: String?

    
    
    
    var currentUserPublisher: AnyPublisher<User?, Never> {
        userSubject.eraseToAnyPublisher()
    }
    
    // Computed property mapping FirebaseAuth.User → your User
        var currentUser: User? {
            guard let fUser = auth.currentUser else { return nil }
            return User(
                id: fUser.uid,
                email: fUser.email ?? "",
                displayName: fUser.displayName,
                photoURL: fUser.photoURL
            )
        }

    override init() {
            super.init()
            // Emit the current (mapped) user
            userSubject.send(currentUser)
            // Listen for Firebase auth-state changes and re-map
            auth.addStateDidChangeListener { [weak self] _, _ in
                self?.userSubject.send(self?.currentUser)
            }
        }


    func signUp(email: String, password: String) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            self?.auth.createUser(withEmail: email, password: password) { result, error in
                if let e = error { promise(.failure(e)) }
                else { promise(.success(())) }
            }
        }
        .eraseToAnyPublisher()
    }

    func signIn(email: String, password: String) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            self?.auth.signIn(withEmail: email, password: password) { result, error in
                if let e = error { promise(.failure(e)) }
                else { promise(.success(())) }
            }
        }
        .eraseToAnyPublisher()
    }

    func signOut() -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            do {
                try self?.auth.signOut()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func signInWithApple() -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            guard let self = self else { return promise(.failure(AuthError.appleAuthenticationFailed)) }

            // Store it so the delegate can fulfill it later
            self.appleSignInPromise = promise
            
            // 1) Create & store a random nonce
            let nonce = Self.randomNonceString()
            self.currentNonce = nonce
            

            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            
            request.nonce = sha256(nonce)

            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.presentationContextProvider = self
            controller.performRequests()
        }
        .eraseToAnyPublisher()
    }
    
    // Helper to make a random string nonce
    static func randomNonceString(length: Int = 32) -> String {
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remaining = length
      while remaining > 0 {
        let randoms = (0 ..< 16).map { _ in UInt8.random(in: 0 ... 255) }
        randoms.forEach { random in
          if remaining == 0 { return }
          if random < charset.count {
            result.append(charset[Int(random)])
            remaining -= 1
          }
        }
      }
      return result
    }
    
    

    func signInWithGoogle(presenting: UIViewController) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                return promise(.failure(AuthError.missingClientID))
            }

            // 1) Configure GoogleSignIn
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            // 2) Kick off the flow
            GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
                if let error = error {
                    return promise(.failure(error))
                }

                // 3) Unwrap the result and its tokens correctly
                guard
                    let user = result?.user,
                    // idToken is Optional<GIDToken>
                    let idTokenString = user.idToken?.tokenString
                else {
                    return promise(.failure(AuthError.googleAuthenticationFailed))
                }

                // accessToken is a non-optional GIDToken
                let accessTokenString = user.accessToken.tokenString

                // 4) Exchange for a Firebase credential
                let credential = GoogleAuthProvider.credential(
                    withIDToken: idTokenString,
                    accessToken: accessTokenString
                )

                // 5) Sign in to Firebase
                Auth.auth().signIn(with: credential) { _, authError in
                    if let authError = authError {
                        promise(.failure(authError))
                    } else {
                        promise(.success(()))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }


}

// MARK: - ASAuthorizationControllerDelegate & PresentationContextProviding

extension AuthService: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Change as needed; this uses the first window
        UIApplication.shared.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        // 1) Extract identity token and string, and unwrap the stored nonce in one go
        guard
            let appleID   = authorization.credential as? ASAuthorizationAppleIDCredential,
            let tokenData = appleID.identityToken,
            let tokenStr  = String(data: tokenData, encoding: .utf8),
            let rawNonce  = currentNonce
        else {
            appleSignInPromise?(.failure(AuthError.appleAuthenticationFailed))
            appleSignInPromise = nil
            return
        }

        // 2) Create the Firebase credential
        let credential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: tokenStr,    // now in scope
            rawNonce: rawNonce
        )

        // 3) Sign in with Firebase
        auth.signIn(with: credential) { [weak self] _, error in
            if let e = error {
                self?.appleSignInPromise?(.failure(e))
            } else {
                self?.appleSignInPromise?(.success(()))
            }
            self?.appleSignInPromise = nil
        }
    }
}

