//
//  HabitListView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation

import SwiftUI

struct HabitListView: View {
    @ObservedObject var viewModel: HabitListViewModel
    @State private var newHabitTitle: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("New Habit", text: $newHabitTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    guard !newHabitTitle.isEmpty else { return }
                    viewModel.addHabit(title: newHabitTitle)
                    newHabitTitle = ""
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()

            List(viewModel.habits) { habit in
                Text(habit.title)
            }
        }
        .navigationTitle("Habits")
    }
}
