//
//  GrilleText.swift
//  Ciphers
//
//  Created by Arjun B on 03/04/23.
//

import SwiftUI

struct GrilleText: View {
    let text = "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased()
    
    @State private var screenWidth: Double = 0
    
    var body: some View {
        ChunkedText(text: text, limit: screenWidth) { char in
            Text(char)
                .font(.title3.monospaced().weight(.semibold))
        }
        .frame(maxWidth: .infinity)
        .overlay {
            Color.clear.measureSize { screenWidth = $0.width }
        }
        .overlay {
            GrillePaper(limit: screenWidth)
                .blendMode(.exclusion)
        }
    }
}

struct GrillePaper: View {
    let initialOffset: CGSize = .init(width: 0, height: 100)
    let text = "...... ......h ....s o. ....t.\n.....n .. ...i. ...... ... c...\n.a... .... ...m ....".uppercased()

    let limit: Double

    @State private var currentOffset = CGSize.zero
    @State private var finalOffset = CGSize.zero
    
    private var totalOffset: CGSize {
        CGSize(
            width: currentOffset.width + finalOffset.width,
            height: currentOffset.height + finalOffset.height
        )
    }
    
    private func getColor(for char: String) -> Color {
        let isEmpty = (char == "." || char == " ")
        return isEmpty ? .clear : .white
    }
    
    var body: some View {
        ChunkedText(text: text, limit: limit) { char in
            Rectangle()
                .fill(.clear)
                .background(getColor(for: char))
                .cornerRadius(2)
                .scaleEffect(x: 1.125, y: 1.15)
        }
        .frame(maxWidth: .infinity)
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

struct GrilleText_Previews: PreviewProvider {
    static var previews: some View {
        GrilleText()
    }
}
