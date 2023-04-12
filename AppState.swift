//
//  AppState.swift
//  Ciphers
//
//  Created by Arjun B on 12/04/23.
//

import Foundation

enum AppPage: Int, CaseIterable {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
}

class AppState: ObservableObject {
    @Published var page: AppPage = .zero
    
    var isFirstPage: Bool {
        page.rawValue <= 0
    }
    
    var isLastPage: Bool {
        page.rawValue >= AppPage.allCases.count - 1
    }
    
    func nextPage() {
        if isLastPage { return }
        
        page = AppPage(rawValue: page.rawValue + 1) ?? .zero
    }
    
    func prevPage() {
        if isFirstPage { return }
        
        page = AppPage(rawValue: page.rawValue - 1) ?? .zero
    }
}
