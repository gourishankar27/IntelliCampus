//
//  Note.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/22/25.
//

import Foundation
import FirebaseFirestore

/// A collaboratively edited note.
/// Uses Firestore’s shared zone or a custom collisions strategy.
struct Note: Identifiable, Codable {
    @DocumentID var id: String?
    var ownerId: String               // Auth.uid of creator
    var content: String               // markdown or plain text
    var collaboratorIds: [String]     // other user UIDs
    var updatedAt: Date
}
