//
//  Tutorial.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation


struct Tutorial: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let isPremium: Bool
    var price: String?        // formatted price string
}
