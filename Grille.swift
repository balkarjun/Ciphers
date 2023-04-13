//
//  Grille.swift
//  Ciphers
//
//  Created by Arjun B on 03/04/23.
//

import SwiftUI

struct GrillePaper: View {
    let initialOffset: CGSize = .init(width: 0, height: 100)
    let text = ".............H.....S.O......T.\n........N........I.........C...\n.A............M......"
    let lineLength: Int

    @State private var currentOffset = CGSize.zero
    @State private var finalOffset = CGSize.zero
    
    private var totalOffset: CGSize {
        CGSize(
            width: currentOffset.width + finalOffset.width,
            height: currentOffset.height + finalOffset.height
        )
    }
    
    var body: some View {
        ChunkedText(
            text: text,
            chunkSize: lineLength,
            blocks: true
        )
        .padding()
        .background(.white.opacity(0.1))
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
    let text = "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased()

    private let charWidth: Double = 18
    private let charHeight: Double = 18
    // space between two consecutive characters
    private let kerning: Double = 6
    // space between rows of characters
    private let lineSpacing: Double = 6
    
    @State private var screenWidth: Double = 0
    
    // number of characters that can fit in a line
    private var lineLength: Int {
        if screenWidth == 0 { return 1 }

        return Int(screenWidth / (charWidth + kerning))
    }
    
    var body: some View {
        ChunkedText(
            text: text,
            chunkSize: lineLength
        )
        .frame(maxWidth: .infinity)
        .overlay {
            Color.clear.measureSize { screenWidth = $0.width }
        }
        .overlay {
            GrillePaper(lineLength: lineLength)
                .blendMode(.exclusion)
        }
    }
}

struct Grille_Previews: PreviewProvider {
    static var previews: some View {
        Grille()
    }
}
