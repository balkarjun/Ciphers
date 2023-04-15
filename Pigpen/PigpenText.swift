//
//  PigpenText.swift
//  
//
//  Created by Arjun B on 05/04/23.
//

import SwiftUI

struct PigpenText: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let text: String
    private let highlighted: String
    private let completed: Set<String>
    
    init(_ text: String, highlighted: String = "", completed: Set<String> = []) {
        self.text = text
        self.highlighted = highlighted.uppercased()
        self.completed = completed
    }
    
    @State private var screenWidth: Double = 0
    
    private func highlightColor(for char: String) -> Color {
        let isHighlighted = highlighted.contains(char)
        
        return isHighlighted ? Color.accentColor.opacity(0.5) : .clear
    }
    
    private func lineColor(for char: String) -> Color {
        
        let isCompleted = completed.contains(char)
        
        let primary: Color = (colorScheme == .dark) ? .white : .black
        let secondary: Color = Color(.systemGray)
        
        return isCompleted ? secondary : primary
    }
    
    var body: some View {
        ChunkedText(text: text, limit: screenWidth) { char in
            PigpenCharacter(
                char,
                lineColor: lineColor(for: char)
            )
            .background {
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(highlightColor(for: char))
                    .scaleEffect(x: 1.25, y: 1.5)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            Color.clear.measureSize { screenWidth = $0.width }
        }
    }
}

struct PigpenText_Previews: PreviewProvider {
    static var previews: some View {
        PigpenText("Sphinx of black quartz, judge my vow".uppercased(), highlighted: "A", completed: ["Q"])
    }
}
