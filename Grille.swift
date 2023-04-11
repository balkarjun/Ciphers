//
//  Grille.swift
//  Ciphers
//
//  Created by Arjun B on 03/04/23.
//

import SwiftUI

struct GrillePaper: View {
    let initialOffset: CGSize = .zero
    let text: String = "             h     s o      t          n        i         c     a            m      "
    let screenWidth: Double

    @State private var currentOffset = CGSize.zero
    @State private var finalOffset = CGSize.zero
    
    private var totalOffset: CGSize {
        CGSize(
            width: currentOffset.width + finalOffset.width,
            height: currentOffset.height + finalOffset.height
        )
    }
    
    private var boxHeight: Double {
        let columns: Int = (text.count - 1) / lineLength

        return Double(columns + 1) * (charHeight + lineSpacing)
    }
    
    private let charWidth: Double = 16
    private let charHeight: Double = 20
    // space between two consecutive characters
    private let kerning: Double = 8
    // space between rows of characters
    private let lineSpacing: Double = 8
        
    // number of characters that can fit in a line
    private var lineLength: Int {
        if screenWidth == 0 { return 1 }

        return Int(screenWidth / (charWidth))
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
                        let isEmpty = (String(char) == " ")
                            Rectangle()
                                .fill(isEmpty ? .clear : .white)
                                .frame(width: charWidth, height: charHeight)
                                .blendMode(.exclusion)
                                .cornerRadius(2)
                    }
                }
            }
        }
        .padding()
        .padding(.vertical)
        .background(.quaternary.opacity(0.5))
        .cornerRadius(8)
        .offset(totalOffset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    currentOffset = gesture.translation
                }
                .onEnded { gesture in
                    let offset = gesture.translation
                    // finalOffset += offset
                    finalOffset = CGSize(width: finalOffset.width + offset.width, height: finalOffset.height + offset.height)
                    currentOffset = .zero
                }
        )
        .onAppear {
            finalOffset = initialOffset
        }
    }
}

struct Grille: View {
    let text = "Viewed through holes of light, hidden in plain sight, the clue faces left from right".uppercased()
    
    private let charWidth: Double = 16
    private let charHeight: Double = 20
    // space between two consecutive characters
    private let kerning: Double = 8
    // space between rows of characters
    private let lineSpacing: Double = 8
    
    @State private var screenWidth: Double = 0
    
    // number of characters that can fit in a line
    private var lineLength: Int {
        if screenWidth == 0 { return 1 }

        return Int(screenWidth / (charWidth))
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
                        Text(String(char))
                            .font(.system(size: 20, weight: .semibold, design: .monospaced))
                            .frame(width: charWidth, height: charHeight)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .overlay {
            Color.clear.measureSize { screenWidth = $0.width }
        }
        .overlay {
            GrillePaper(screenWidth: screenWidth)
        }
    }
}

struct Grille_Previews: PreviewProvider {
    static var previews: some View {
        Grille()
    }
}
