//
//  Route.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/21/25.
//

import Foundation

// App/Route.swift

import Foundation

/// Defines all navigation destinations in the app.
enum Route: Hashable {
    /// The home (module selection) screen
    case home
    
    /// Habit Tracker flow
    case habitList
    
    /// Tutorials catalog flow
    case tutorialCatalog
    
    /// Tutorial detail screen, carrying the tutorial’s unique ID
    case tutorialDetail(id: UUID)
    
    /// Real-time collaborative notes flow
    case notesCollab
    
    /// AR-powered campus navigator flow
    case arCampus
    
    /// On-device ML photo classifier flow
    case photoClassifier
    
    /// Location-aware social feed flow
    case socialFeed
}


