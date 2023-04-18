//
//  CaesarWheel.swift
//  Ciphers
//
//  Created by Arjun B on 31/03/23.
//

import SwiftUI

struct CaesarWheel: View {
    @Binding var shift: Int
    
    @State private var currentAngle: Angle = .degrees(0)
    @State private var finalAngle: Angle = .degrees(-0.1)
    
    @Environment(\.colorScheme) private var colorScheme
    
    private let characters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    private var firstShiftedLetter: String {
        cshift(message: "A", by: shift)
    }
    
    private let size: Double = 360
    private let spacing: Double = 40
    
    private var innerSize: Double {
        size - 2*spacing
    }
    
    private var arcAngle: Double {
        size / Double(characters.count)
    }
    
    private func updateShift() {
        let totalDegrees = (currentAngle + finalAngle).degrees - (arcAngle/2)
        let calc = floor(totalDegrees / arcAngle)
        let result = Int(calc + 1) * -1
        
        let count = characters.count
        
        self.shift = (count + (result % count)) % count
    }
    
    private var resetButtonAccessibilityLabel: String {
        if shift == 0 {
            return "Tapping this will reset any shifts you've made."
        }
        
        return "Shifted by \(shift). 'A' is shifted to '\(firstShiftedLetter)'. Tap to reset."
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemGray4))
                .frame(width: size, height: size)
                .accessibilityHidden(true)
            
            ArcText(size: size)
                .accessibilityElement(children: .ignore)
            
            Circle()
                .fill(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray6))
                .frame(width: innerSize, height: innerSize)
                .overlay {
                    ForEach(Array(characters.enumerated()), id: \.offset) { index, char in
                        let angle: Double = Double(index) * arcAngle
                        let lineAngle = Double(index) * arcAngle - arcAngle/2
                        
                        Text(char)
                            .font(.body.monospaced().weight(.semibold))
                            .offset(y: -innerSize/2 + 15)
                            .rotationEffect(.degrees(angle))
                            .foregroundColor(char == firstShiftedLetter ? .primary : .secondary)
                        
                        Rectangle()
                            .fill(colorScheme == .dark ? Color(.systemGray3) : Color(.systemGray5))
                            .frame(width: 1)
                            .rotationEffect(.degrees(lineAngle))
                    }
                    .accessibilityElement(children: .ignore)
                }
                .rotationEffect(currentAngle + finalAngle)
                .gesture (
                    RotationGesture()
                        .onChanged { angle in
                            currentAngle = angle
                            
                            updateShift()
                        }
                        .onEnded { angle in
                            finalAngle += angle
                            currentAngle = .degrees(0)
                        }
                )
                .accessibilityElement(children: .ignore)

            Circle()
                .fill(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray6))
                .frame(width: innerSize/1.75, height: innerSize/1.75)
                .accessibilityHidden(true)
            
            Circle()
                .strokeBorder(colorScheme == .dark ? Color(.systemGray3) : Color(.systemGray5), lineWidth: 1)
                .frame(width: innerSize/1.75, height: innerSize/1.75)
                .accessibilityHidden(true)

            Button {
                shift = 0
                withAnimation {
                    currentAngle = .degrees(0)
                    finalAngle = .degrees(-0.1)
                }
            } label: {
                Circle()
                    .fill(.clear)
                    .frame(width: size/2.5, height: size/2.5)
                    .overlay {
                        Text(shift, format: .number)
                            .font(.title3.monospaced().bold())
                            .animation(.none, value: shift)
                            .foregroundColor(.primary)
                    }
                    .accessibilityLabel(resetButtonAccessibilityLabel)
            }
            
            Button {
                withAnimation {
                    finalAngle -= .degrees(arcAngle)
                    
                    updateShift()
                }
            } label: {
                Label("Shift Forward", systemImage: "arrow.down.circle.fill")
                    .font(.title.weight(.semibold))
                    .symbolRenderingMode(.hierarchical)
                    .labelStyle(.iconOnly)
            }
            .offset(x: -(size/2 + 24))
            .rotationEffect(.degrees(-45))
            
            Button {
                withAnimation {
                    finalAngle += .degrees(arcAngle)
                    
                    updateShift()
                }
            } label: {
                Label("Shift Back", systemImage: "arrow.down.circle.fill")
                    .font(.title.weight(.semibold))
                    .symbolRenderingMode(.hierarchical)
                    .labelStyle(.iconOnly)
            }
            .offset(x: size/2 + 24)
            .rotationEffect(.degrees(45))
        }
    }
}

struct ArcText: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let size: Double
    
    private let characters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    private var arcAngle: Double {
        size / Double(characters.count)
    }
    
    private var lineColor: Color {
        colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray2)
    }
    
    var body: some View {
        Circle()
            .fill(.clear)
            .frame(width: size, height: size)
            .overlay {
                ForEach(Array(characters.enumerated()), id: \.offset) { index, char in
                    let angle = Double(index) * arcAngle
                    
                    Text(char)
                        .font(.body.monospaced().weight(.semibold))
                        .offset(y: -size/2 + 20)
                        .rotationEffect(.degrees(angle))
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: 1)
                        .rotationEffect(.degrees(angle - arcAngle/2))
                }
            }
    }
}

struct CaesarTest: View {
    @State private var shift: Int = 0
    
    var body: some View {
        CaesarWheel(shift: $shift)
    }
}

struct CaesarWheel_Previews: PreviewProvider {
    static var previews: some View {
        CaesarTest()
    }
}
