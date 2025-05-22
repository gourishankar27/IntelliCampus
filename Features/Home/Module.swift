//
//  Module.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/21/25.
//

import Foundation

enum Module: String, CaseIterable, Identifiable {
    case habit        = "Habit Tracker"
    case tutorials    = "Tutorials"
    case notesCollab  = "Notes"
    case arCampus     = "AR Navigator"
    case photoClassifier = "Photo Classifier"
    case socialFeed   = "Social Feed"

    var id: String { rawValue }
}
