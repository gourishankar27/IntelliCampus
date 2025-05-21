//
//  HabitListViewModel.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import Combine

class HabitListViewModel: ObservableObject {
    @Published private(set) var habits: [Habit] = []
    private let service: HabitServiceProtocol

    init(service: HabitServiceProtocol) {
        self.service = service
        fetchHabits()
    }

    func fetchHabits() {
        habits = service.getAllHabits()
    }

    func addHabit(title: String) {
        service.addHabit(title: title)
        fetchHabits()
    }
}
