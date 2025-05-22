//
//  TutorialService.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation

import Combine
import StoreKit

/// Protocol for tutorial listing, purchasing, and content
protocol TutorialServiceProtocol {
    func requestProducts()
    func getAllTutorials() -> [Tutorial]
    func isTutorialUnlocked(_ tutorial: Tutorial) -> Bool
    func getTutorialContent(_ tutorial: Tutorial) -> String
    func purchaseTutorial(_ tutorial: Tutorial) -> AnyPublisher<Bool, Error>
    func markTutorialCompleted(_ tutorial: Tutorial)
}

/// A basic, in‐memory stub implementation of `TutorialServiceProtocol`.
///
/// Use this during early development or testing; no real StoreKit or persistence yet.
class TutorialService: TutorialServiceProtocol {

    /// Tracks which tutorial IDs the user has unlocked (purchased).
    ///
    /// — **Note:** This is ephemeral memory; app restart resets all unlocks.
    private var unlocked: Set<UUID> = []

    
    /// Initiates a StoreKit request to fetch product info (localized price, titles).
    ///
    /// — **TODO:** Implement `SKProductsRequest` + delegate to populate SKProducts.
    func requestProducts() {
        // TODO: call StoreKit to fetch SKProducts
    }

    
    /// Returns the full list of tutorials available in the app.
    ///
    /// - Returns: An array combining free and premium tutorials.
    ///
    /// — **TODO:** Merge with real StoreKit `SKProduct` data for accurate pricing.
    func getAllTutorials() -> [Tutorial] {
        // TODO: replace with real data/fetched products
        return [
            Tutorial(id: UUID(), title: "Intro to SwiftUI", description: "Learn the basics.", isPremium: false, price: nil),
            Tutorial(id: UUID(), title: "Advanced Combine", description: "Deep dive.", isPremium: true, price: "$4.99")
        ]
    }

    
    /// Checks if the given tutorial has been unlocked (purchased) by the user.
    ///
    /// - Parameter tutorial: The tutorial to check.
    /// - Returns: `true` if its `id` is in the `unlocked` set.
    func isTutorialUnlocked(_ tutorial: Tutorial) -> Bool {
        unlocked.contains(tutorial.id)
    }


    /// Retrieves the content for a tutorial, gating access for locked premium items.
    ///
    /// - Parameter tutorial: The tutorial whose content is requested.
    /// - Returns:
    ///   - Empty string if the tutorial is premium and not unlocked.
    ///   - Otherwise, placeholder markdown content.
    ///
    /// — **TODO:** Fetch real markdown or video URL from disk or network.
    func getTutorialContent(_ tutorial: Tutorial) -> String {
        // TODO: fetch markdown or video URL from disk or network
        return tutorial.isPremium && !isTutorialUnlocked(tutorial)
            ? "" : "# \(tutorial.title) Content here..."
    }

    
    
    /// Initiates an in‐app purchase flow for the specified tutorial.
    ///
    /// - Parameter tutorial: The premium tutorial to purchase.
    /// - Returns: A Combine publisher emitting `true` on success, or an `Error`.
    ///
    /// — **Stub Implementation:**
    ///   Emits `true` after a 1-second delay, then records the unlock.
    ///   Replace with real `SKPaymentQueue` handling and error mapping.
    func purchaseTutorial(_ tutorial: Tutorial) -> AnyPublisher<Bool, Error> {
        // TODO: integrate StoreKit purchase flow
        Just(true)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .map { [weak self] success in
                if success { self?.unlocked.insert(tutorial.id) }
                return success
            }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    
    
    /// Marks a tutorial as completed (e.g. for progress tracking).
    ///
    /// - Parameter tutorial: The tutorial to mark.
    ///
    /// — **TODO:** Persist completion state (UserDefaults, Core Data, or remote).
    func markTutorialCompleted(_ tutorial: Tutorial) {
        // TODO: persist completion state
    }
}
