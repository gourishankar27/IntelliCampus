//
//  TutorialCatalogViewModel.swift
//  IntelliCampus
//
//  Created by Gourishankar Bansode on 5/20/25.
//

import Foundation
import Combine
import StoreKit

class TutorialCatalogViewModel: ObservableObject {
    @Published private(set) var tutorials: [Tutorial] = []
    private let service: TutorialServiceProtocol

    init(service: TutorialServiceProtocol) {
        self.service = service
        fetchTutorials()
        service.requestProducts()
    }

    func fetchTutorials() {
        tutorials = service.getAllTutorials()
    }
}
