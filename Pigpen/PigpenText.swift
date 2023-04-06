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
    private let replaced: Set<String>
    private let lineColor: Color
    
    init(_ text: String, highlighted: String = "", replaced: Set<String> = [], lineColor: Color = .primary) {
        self.text = text
        self.highlighted = highlighted
        self.replaced = replaced
        self.lineColor = lineColor
    }
    
    private let charWidth: Double = 20
    private let charHeight: Double = 20
    // space between two consecutive characters
    private let kerning: Double = 8
    // space between rows of characters
    private let lineSpacing: Double = 8
    
    @State private var screenWidth: Double = 0
    
    // number of characters that can fit in a line
    private var lineLength: Int {
        if screenWidth == 0 { return 1 }

        return Int(screenWidth / (charWidth + kerning))
    }
    // splits the text into an array of characters for each line
    private var rowText: [[String]] {
        return Array(text.uppercased().map { String($0) }).chunked(into: lineLength)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: lineSpacing) {
            ForEach(rowText, id: \.self) { line in
                HStack(spacing: kerning) {
                    ForEach(line, id: \.self) { char in
                        VStack(spacing: lineSpacing/2) {
                            let isCompleted = replaced.contains(String(char))
                            let isHighlighted = (String(char)) == highlighted
                            
                            if String(char) == " " {
                                BlankSpaceCharacter
                            } else if String(char) == "," {
                                CommaCharacter
                            } else {
                                if isCompleted {
                                    Text(String(char))
                                        .font(.title2.weight(.semibold))
                                        .frame(width: charWidth, height: charHeight)
                                } else {
                                    PigpenCharacter(String(char), lineColor: lineColor)
                                        .background(isHighlighted ? .green.opacity(0.6) : .clear)
                                }
                            }
                        }
                    }
                }
            }
        }
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
        PigpenText("Sphinx of black quartz, judge my vow")
    }
}
