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
    
    let encrypted = cshift(message: "VIEWED THROUGH HOLES OF LIGHT,\nHIDDEN IN PLAIN SIGHT, THE CLUE\nFACES LEFT FROM RIGHT", by: 10)
    
    let decrypted = "VIEWED THROUGH HOLES OF LIGHT,\nHIDDEN IN PLAIN SIGHT, THE CLUE\nFACES LEFT FROM RIGHT"
    
    let blocked = "...... ......H ....S O. ....T.\n.....N .. ...I. ...... ... C...\n.A... .... ...M ....."
    
    let solution = "MACINTOSH"
    
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
    
    func reset() {
        page = .zero
    }
}

func cshift(message: String, by shift: Int) -> String {
    let first = 65
    let last  = 65 + 25
    let count = 26
    
    let result = message.uppercased().utf8.map { char in
        let value = Int(char)
        // if not in A...Z, leave unchanged
        if value < first || value > last {
            return value
        }
        // amount by which character should be offset
        var offset = (value - first) + shift
        // bring within A...Z
        offset = (offset % count + count) % count
        
        return (first + offset)
    }
    
    return String(result.map { Character(UnicodeScalar($0)!) })
}
