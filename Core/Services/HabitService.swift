//
//  HabitService.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation

/// Protocol for habit CRUD operations
/// Defines the “contract” for any habits data source.

// Why a protocol?
///Dependency Injection (DI): your ViewModels only know they need “something that conforms to HabitServiceProtocol,” not the concrete class.
///Testability: in unit tests you can inject a mock/stub service that implements this protocol.

/// By programming to this protocol, ViewModels remain agnostic of
/// how habits are persisted—enabling easy swapping of implementations
/// (in-memory, Core Data, network, etc.) and clean unit testing.
protocol HabitServiceProtocol {
    
    /// Fetches the complete list of stored habits.
    ///
    /// - Returns: An array of `Habit` models representing all current habits.
    func getAllHabits() -> [Habit]
    
    /// Creates and stores a new habit with the given title.
    ///
    /// - Parameter title: The user-facing title for the new habit (e.g., "Drink Water").
    ///
    /// **Gotcha:**
    /// The implementing service should generate a unique `UUID` for the new `Habit`.
    /// In real persistence layers, this method might be `async throws` to handle I/O errors.
    func addHabit(title: String)
}



/// A simple, in‐memory implementation of `HabitServiceProtocol`.
///
/// Use this during early development or testing—data lives only
/// for the lifetime of the app process.
class HabitService: HabitServiceProtocol {
    
    /// Backing store for all habits.
    ///
    /// — **Note:** This array is private and ephemeral.
    ///   When the app quits, all habits are lost.
    private var storage: [Habit] = []

    /// Retrieves the full list of stored habits.
    ///
    /// - Returns: An array of `Habit` objects currently in memory.
    ///
    /// **Gotcha:**
    /// This is a synchronous call—if you swap in a real
    /// database or network store later, consider making this
    /// `async throws` or returning a Combine `Publisher`.
    func getAllHabits() -> [Habit] {
        storage
    }

    
    /// Creates a new `Habit` and appends it to the in-memory store.
    ///
    /// - Parameter title: The display title for the new habit.
    ///
    /// **Implementation details:**
    /// - Generates a fresh `UUID()` for `Habit.id`.
    /// - Appends the new model to `storage`.
    ///
    /// **Gotcha:**
    /// No validation is performed here (e.g., non‐empty titles).
    /// In a real service you might `throw` on invalid input
    /// or propagate I/O errors from disk/network.
    func addHabit(title: String) {
        let habit = Habit(id: UUID().uuidString,
                          title: title,
                          createdAt: Date(),
                          completedDates: [] 
        )
        storage.append(habit)
    }
}
