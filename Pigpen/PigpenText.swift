//
//  PigpenText.swift
//  
//
//  Created by Arjun B on 05/04/23.
//

import SwiftUI

struct PigpenText: View {
    private let text: String
    
    init(_ text: String) {
        self.text = text
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
        return Array(text.map { String($0) }).chunked(into: lineLength)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: lineSpacing) {
            ForEach(rowText, id: \.self) { line in
                HStack(spacing: kerning) {
                    ForEach(line, id: \.self) { char in
                        if String(char) == " " {
                            BlankSpaceCharacter
                        } else if String(char) == "," {
                            CommaCharacter
                        } else {
                            PigpenCharacter(String(char))
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
