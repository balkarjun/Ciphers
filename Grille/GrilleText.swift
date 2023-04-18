//
//  GrilleText.swift
//  Ciphers
//
//  Created by Arjun B on 03/04/23.
//

import SwiftUI

struct GrilleText: View {
    @EnvironmentObject var state: AppState
    
    @State private var screenWidth: Double = 0
    
    var body: some View {
        ChunkedText(text: state.decrypted, limit: screenWidth) { char in
            Text(char)
                .font(.title3.monospaced().weight(.semibold))
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("When viewed through the stencil, the message reads: 'H' 'S' 'O' 'T' 'N' 'I' 'C' 'A' 'M'")
        .accessibilityAddTraits(.isHeader)
        .frame(maxWidth: .infinity)
        .overlay {
            Color.clear.measureSize { screenWidth = $0.width }
        }
        .overlay {
            GrillePaper(limit: screenWidth)
                .blendMode(.exclusion)
                .accessibilityHidden(true)
        }
    }
}

struct GrillePaper: View {
    @EnvironmentObject var state: AppState
    
    let limit: Double
    
    @State private var currentOffset = CGSize.zero
    @State private var finalOffset = CGSize.zero
    
    private let initialOffset: CGSize = .init(width: 0, height: 180)
    
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
        VStack(alignment: .leading, spacing: 0) {
            ChunkedText(text: state.blocked, limit: limit) { char in
                Rectangle()
                    .fill(.clear)
                    .frame(width: 24, height: 24)
                    .background(getColor(for: char))
                    .cornerRadius(2)
            }
            .padding()
            
            Divider()
            
            Text("stencil")
                .foregroundColor(.white.opacity(0.6))
                .font(.body.monospaced().bold())
                .padding()
        }
        .frame(maxWidth: .infinity)
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
            .padding(200)
            .environmentObject(AppState())
    }
}
