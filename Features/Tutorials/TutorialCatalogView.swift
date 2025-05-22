//
//  TutorialCatalogView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import SwiftUI

struct TutorialCatalogView: View {
    @ObservedObject var viewModel: TutorialCatalogViewModel
    @EnvironmentObject var coordinator: AppCoordinator

//    var onSelect: (Tutorial) -> Void
//
//    var body: some View {
//        List(viewModel.tutorials) { tutorial in
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(tutorial.title).font(.headline)
//                    Text(tutorial.description).font(.subheadline)
//                }
//                Spacer()
//                if tutorial.isPremium {
//                    Text(tutorial.price ?? "")
//                        .badge("💎")
//                } else {
//                    Text("Free")
//                        .badge("✅")
//                }
//            }
//            .contentShape(Rectangle())
//            .onTapGesture { onSelect(tutorial) }
//        }
//        .navigationTitle("Tutorials")
//    }
    
    var body: some View {
        List(viewModel.tutorials, id: \.id) { tutorial in
            Button {
                coordinator.path.append(Route.tutorialDetail(tutorial: tutorial))
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(tutorial.title).font(.headline)
                        Text(tutorial.description).font(.subheadline)
                    }
                    Spacer()
                    if tutorial.isPremium {
                        Text(tutorial.price ?? 0, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .badge("💎")
                    } else {
                        Text("Free").badge("✅")
                    }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .navigationTitle("Tutorials")
        }
}
