//
//  Habit.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation

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


struct Habit: Identifiable {
    
    /// Unique identifier for this habit instance.
    /// Should be generated (e.g. `UUID()`) when we create a new Habit.
    let id: UUID
    
    /// The display title of the habit (e.g. "Drink Water", "Read 30 min").
    /// Immutable --> if we need to edit the title, create a new Habit or handle via ViewModel.
    let title: String
}
