//
//  Habit.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import FirebaseFirestore
/// Represents a user habit


///In Swift (and SwiftUI), Identifiable is a protocol that lets types provide a stable, unique identifier. SwiftUI’s List, ForEach, and other diffing/animation APIs lean on it to know which model is which when your data changes.

//protocol Identifiable {
//    /// The type used for uniquely identifying this instance.
//    associatedtype ID: Hashable
//
//    /// A stable identifier for this instance.
//    var id: ID { get }
//}

//When we write:

//struct Habit: Identifiable { … }
//// …
//List(habits) { habit in
//  Text(habit.title)
//}

//SwiftUI compares each habit.id to animate insertions, moves, and deletions for us.



/// A single habit entry for offline-first Firestore.
/// We store creation date and optional completion history.
struct Habit: Identifiable, Codable {
    @DocumentID var id: String?         // Firestore document ID
    var title: String                  // e.g. "Meditate"
    var createdAt: Date                // when it was added
    var completedDates: [Date] = []    // days marked complete
}

