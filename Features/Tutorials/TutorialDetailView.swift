//
//  TutorialDetailView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import SwiftUI

struct TutorialDetailView: View {
    @ObservedObject var viewModel: TutorialDetailViewModel

    var body: some View {
        ScrollView {
            if viewModel.isUnlocked || !viewModel.tutorial.isPremium {
                Text(viewModel.content)
                    .padding()
            } else {
                Text("Locked")
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.isUnlocked || !viewModel.tutorial.isPremium {
                    Button("Mark Completed") {
                        viewModel.markCompleted()
                    }
                    .disabled(viewModel.isCompleted)
                } else {
                    Button("Unlock") {
                        viewModel.unlock()
                    }
                }
            }
        }
        .navigationTitle(viewModel.tutorial.title)
    }
}
