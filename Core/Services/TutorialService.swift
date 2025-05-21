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

/// Basic stub implementation
class TutorialService: TutorialServiceProtocol {
    private var unlocked: Set<UUID> = []

    func requestProducts() {
        // TODO: call StoreKit to fetch SKProducts
    }

    func getAllTutorials() -> [Tutorial] {
        // TODO: replace with real data/fetched products
        return [
            Tutorial(id: UUID(), title: "Intro to SwiftUI", description: "Learn the basics.", isPremium: false, price: nil),
            Tutorial(id: UUID(), title: "Advanced Combine", description: "Deep dive.", isPremium: true, price: "$4.99")
        ]
    }

    func isTutorialUnlocked(_ tutorial: Tutorial) -> Bool {
        unlocked.contains(tutorial.id)
    }

    func getTutorialContent(_ tutorial: Tutorial) -> String {
        // TODO: fetch markdown or video URL from disk or network
        return tutorial.isPremium && !isTutorialUnlocked(tutorial)
            ? "" : "# \(tutorial.title) Content here..."
    }

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

    func markTutorialCompleted(_ tutorial: Tutorial) {
        // TODO: persist completion state
    }
}
