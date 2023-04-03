//
//  Grille.swift
//  Ciphers
//
//  Created by Arjun B on 03/04/23.
//

import SwiftUI

struct GrillePaper: View {
    let initialOffset: CGSize = .zero
    let text: [String] = "             h     s o      t          n        i         c     a            m      ".uppercased().map{ String($0) }

    @State private var currentOffset = CGSize.zero
    @State private var finalOffset = CGSize.zero
    
    private var totalOffset: CGSize {
        CGSize(
            width: currentOffset.width + finalOffset.width,
            height: currentOffset.height + finalOffset.height
        )
    }
    
    @State private var screenWidth: Double = 0
    // size of bounding box of characters
    private let charBoxSize: CGSize = .init(width: 25, height: 25)
    
    // number of characters in a line
    private var lineLength: Int {
        if screenWidth == 0 { return 1 }

        return Int(screenWidth / charBoxSize.width)
    }
    
    private var boxHeight: Double {
        let columns: Int = (text.count - 1) / lineLength
        
        return Double(columns + 1) * charBoxSize.height
    }
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .allowsHitTesting(false)
            .measureSize { screenWidth = $0.width }
            .overlay {
                Rectangle()
                    .fill(.quaternary.opacity(0.5))
                    .overlay(alignment: .topLeading) {
                        ForEach(Array(text.enumerated()), id: \.offset) { index, character in
                            let colNumber = (index) % lineLength
                            let xOffset = Double(colNumber) * charBoxSize.width
                            let rowNumber: Int = (index) / lineLength
                            let yOffset = Double(rowNumber) * charBoxSize.height
                            let _ = print(rowNumber)
                            Rectangle()
                                .fill(.white)
                                .blendMode(.exclusion)
                                .frame(width: charBoxSize.width, height: charBoxSize.height)
                                .offset(x: xOffset, y: yOffset)
                                .opacity(character == " " ? 0 : 1)
                        }
                    }
//                    .frame(width: 800, height: 100)
                    .frame(width: screenWidth, height: boxHeight)
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
            }
            .onAppear {
                finalOffset = initialOffset
            }
    }
}

struct Grille: View {
    let text: [String] = "viewed through holes of light, hidden in plain sight, the clue faces left from right".uppercased().map{ String($0) }
    
    @State private var screenWidth: Double = 0
    // size of bounding box of characters
    private let charBoxSize: CGSize = .init(width: 25, height: 25)
    
    // number of characters in a line
    private var lineLength: Int {
        if screenWidth == 0 { return 1 }

        return Int(screenWidth / charBoxSize.width)
    }
    
    var body: some View {
        ZStack {
            ForEach(Array(text.enumerated()), id: \.offset) { index, character in
                let colNumber: Int = (index) % lineLength
                let xOffset: Double = Double(colNumber) * charBoxSize.width
                let rowNumber: Int = (index) / lineLength
                let yOffset: Double = Double(rowNumber) * charBoxSize.height

                Text(character)
                    .font(.system(size: 20, weight: .semibold, design: .serif))
                    .frame(width: charBoxSize.width, height: charBoxSize.height)
                    .offset(x: xOffset, y: yOffset)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            Color.clear
                .measureSize { screenWidth = $0.width }
        }
        .overlay {
            GrillePaper()
        }
    }
}

struct Grille_Previews: PreviewProvider {
    static var previews: some View {
        Grille()
    }
}
