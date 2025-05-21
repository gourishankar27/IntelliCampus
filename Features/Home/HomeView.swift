//
//  HomeView.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import SwiftUI


struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        List(viewModel.modules) { module in
            Text(module.rawValue)
                .onTapGesture { viewModel.select(module) }
        }
        .navigationTitle("IntelliCampus")
    }
}
