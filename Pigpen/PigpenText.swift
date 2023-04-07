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
    
    init(_ text: String, highlighted: String = "", completed: Set<String>) {
        self.text = text
        self.highlighted = highlighted.uppercased()
        self.completed = completed
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
                HStack(spacing: 0) {
                    ForEach(line, id: \.self) { char in
                        let isHighlighted = ((String(char)) == highlighted)
                        let isCompleted = completed.contains(String(char))
                        
                        if String(char) == " " {
                            BlankSpaceCharacter
                        } else if String(char) == "," {
                            CommaCharacter
                        } else {
                            PigpenCharacter(String(char), lineColor: isCompleted ? .secondary : .primary)
                                .padding(.horizontal, kerning/2)
                                .padding(.vertical, 8)
                                .background {
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(.green.opacity(0.5))
                                        .opacity(isHighlighted ? 1 : 0)
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
        PigpenText("Sphinx of black quartz, judge my vow", highlighted: "A", completed: ["Q"])
    }
}
