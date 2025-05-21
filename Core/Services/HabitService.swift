//
//  HabitService.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation

/// Protocol for habit CRUD operations
protocol HabitServiceProtocol {
    func getAllHabits() -> [Habit]
    func addHabit(title: String)
}

/// Simple in-memory implementation
class HabitService: HabitServiceProtocol {
    private var storage: [Habit] = []

    func getAllHabits() -> [Habit] {
        storage
    }

    func addHabit(title: String) {
        let habit = Habit(id: UUID(), title: title)
        storage.append(habit)
    }
}
