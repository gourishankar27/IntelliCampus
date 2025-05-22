//
//  DataService.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/21/25.
//

import Foundation

import Combine

protocol DataServiceProtocol {
  func fetchHabits() -> AnyPublisher<[Habit], Error>
  func addHabit(_ habit: Habit) -> AnyPublisher<Void, Error>
  // expand for Tutorials, Notes, Photos, Feed…
}
