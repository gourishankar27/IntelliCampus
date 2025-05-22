//
//  User.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/22/25.
//

import Foundation

// Core/Models/User.swift

import Foundation
import FirebaseFirestore

/// A signed-in user in Firebase Auth + Firestore
struct User: Identifiable, Codable {
    /// Maps to Firestore document ID = Auth.uid
    @DocumentID var id: String?
    var email: String
    var displayName: String?
    var photoURL: URL?
}
