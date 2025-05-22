//
//  PhotoClassification.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/22/25.
//

import Foundation
import FirebaseFirestore

/// A photo taken by the user, classified on-device then stored.
struct PhotoClassification: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var imageURL: URL                  // local file URL or Cloud Storage URL
    var label: String                  // e.g. "Math Diagram"
    var confidence: Double             // 0.0 … 1.0
    var createdAt: Date
}
