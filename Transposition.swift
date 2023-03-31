//
//  Transposition.swift
//  Ciphers
//
//  Created by Arjun B on 31/03/23.
//

import SwiftUI

struct Box: View {
    let text: String
    let initialOffset: CGSize
    
    @State private var currentOffset = CGSize.zero
    @State private var finalOffset = CGSize.zero
    
    private var totalOffset: CGSize {
        CGSize(
            width: currentOffset.width + finalOffset.width,
            height: currentOffset.height + finalOffset.height
        )
    }

    var body: some View {
        Rectangle()
            .fill(.clear)
            .allowsHitTesting(false)
            .overlay {
                Rectangle()
                    .fill(.quaternary)
                    .overlay {
                        Text(text)
                    }
                    .frame(width: 80, height: 80)
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

struct Transposition: View {
    var body: some View {
        ZStack {
            Box(text: "M", initialOffset: CGSize(width: -80, height: -80))
            Box(text: "A", initialOffset: CGSize(width: 0, height: -80))
            Box(text: "C", initialOffset: CGSize(width: 80, height: -80))
            Box(text: "I", initialOffset: CGSize(width: -80, height: 0))
            Box(text: "N", initialOffset: .zero)
            Box(text: "T", initialOffset: CGSize(width: 80, height: 0))
            Box(text: "O", initialOffset: CGSize(width: -80, height: 80))
            Box(text: "S", initialOffset: CGSize(width: 0, height: 80))
            Box(text: "H", initialOffset: CGSize(width: 80, height: 80))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.1))
    }
}

struct Transposition_Previews: PreviewProvider {
    static var previews: some View {
        Transposition()
    }
}
