//
//  TutorialDetailViewModel.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import Combine
//import StoreKit

class TutorialDetailViewModel: ObservableObject {
    @Published var content: String = ""
    @Published var isUnlocked: Bool = false
    @Published var isCompleted: Bool = false

    private let service: TutorialServiceProtocol
    let tutorial: Tutorial
    private var cancellables = Set<AnyCancellable>()

    init(service: TutorialServiceProtocol, tutorial: Tutorial) {
        self.service = service
        self.tutorial = tutorial
        checkUnlockStatus()
        loadContent()
    }

    func checkUnlockStatus() {
        isUnlocked = service.isTutorialUnlocked(tutorial)
    }

    func loadContent() {
        content = service.getTutorialContent(tutorial)
    }

    func unlock() {
        service.purchaseTutorial(tutorial)
            .sink { completion in
                // handle errors
            } receiveValue: { success in
                self.isUnlocked = success
                if success { self.loadContent() }
            }
            .store(in: &cancellables)
    }

    func markCompleted() {
        isCompleted = true
        service.markTutorialCompleted(tutorial)
    }
}
