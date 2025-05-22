//
//  Tutorial.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import FirebaseFirestore

/// Represents a single tutorial item in the app.
///
/// Conforms to `Identifiable` so SwiftUI can track changes in lists.
/// Keeps “pure” model properties; formatting (e.g. of price) is handled by ViewModel.

struct Tutorial: Identifiable, Codable, Hashable  {
    @DocumentID var id: String?
    
    /// Short title for display in lists.
    let title: String
    
    /// Longer description shown on a detail screen.
    let description: String
    
    /// Flag that determines if this tutorial is behind a paywall.
    /// View code can show a lock icon or styled background based on this.
    let isPremium: Bool
    
    /// The raw price value in dollars (e.g. 4.99).
    ///
    /// — **Domain vs. Presentation**
    ///   Keep this as a `Double?` in your core model.
    ///   Formatting to `String` (e.g. `"$4.99"`) should happen in your ViewModel or via a `NumberFormatter`.
    var price: Double?
    
    var markdownContent: String?       // loaded from Firestore or local cache
}
