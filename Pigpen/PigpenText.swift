//
//  PigpenText.swift
//  
//
//  Created by Arjun B on 05/04/23.
//

import SwiftUI

struct PigpenText: View {
    private let text: String
    private let highlighted: String
    private let completed: Set<String>
    
    init(_ text: String, highlighted: String = "", completed: Set<String> = []) {
        self.text = text
        self.highlighted = highlighted.uppercased()
        self.completed = completed
    }
    
    private let charWidth: Double = 18
    private let charHeight: Double = 18
    // space between two consecutive characters
    private let kerning: Double = 6
    // space between rows of characters
    private let lineSpacing: Double = 0
    
    @State private var screenWidth: Double = 0
    
    // number of characters that can fit in a line
    private var lineLength: Int {
        if screenWidth == 0 { return 1 }

        return Int(screenWidth / (charWidth + kerning))
    }
    
    var body: some View {
        ChunkedText(text: text, chunkSize: lineLength, charWidth: charWidth, charHeight: charHeight, pigpen: true, highlighted: highlighted, completed: completed)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            Color.clear.measureSize { screenWidth = $0.width }
        }
    }
    
    private var BlankSpaceCharacter: some View {
        Rectangle()
            .fill(.clear)
            .frame(width: charWidth, height: charHeight)
    }
    
    private var CommaCharacter: some View {
        Text(",")
            .font(.system(size: 25, weight: .bold))
            .frame(width: charWidth, height: charHeight)
    }
}

struct PigpenText_Previews: PreviewProvider {
    static var previews: some View {
        PigpenText("Sphinx of black quartz, judge my vow", highlighted: "A", completed: ["Q"])
    }
}
