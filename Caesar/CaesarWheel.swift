//
//  CaesarWheel.swift
//  Ciphers
//
//  Created by Arjun B on 31/03/23.
//

import SwiftUI

struct CaesarWheel: View {
    @Environment(\.colorScheme) private var colorScheme
    let characters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    @State private var currentAngle: Angle = .degrees(0)
    @State private var finalAngle: Angle = .degrees(-0.1)
    
    @Binding var shift: Int

    var body: some View {
        Circle()
            .fill(colorScheme == .dark ? Color(.systemGray6) : Color(.systemGray4))
            .frame(width: 360, height: 360)
            .overlay {
                ForEach(Array(characters.enumerated()), id: \.offset) { index, char in
                    let angle = Double(index) * (360.0 / Double(characters.count))
                    let numericalOffset: Double = Double(index) - 0.5
                    let lineAngle = numericalOffset * (360.0 / Double(characters.count))
                    
                    Text(char)
                        .font(.body.monospaced().weight(.semibold))
                        .rotationEffect(.degrees(90))
                        .offset(x: 150 + 8)
                        .rotationEffect(.degrees(-90))
                        .rotationEffect(.degrees(angle))
                    
                    
                    Rectangle()
                        .frame(width: 1)
                        .rotationEffect(.degrees(lineAngle))
                        .opacity(0.05)
                }
            }
            .overlay {
                Circle()
                    .fill(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray6))
                    .frame(width: 280, height: 280)
                    .overlay {
                        ForEach(Array(characters.enumerated()), id: \.offset) { index, char in
                            let angle: Double = Double(index) * (360.0 / Double(characters.count))
                            let numericalOffset: Double = Double(index) - 0.5
                            let lineAngle: Double = numericalOffset * (360.0 / Double(characters.count))

                            Text(char)
                                .font(.body.monospaced().weight(.semibold))
                                .rotationEffect(.degrees(90))
                                .offset(x: 150 - 24)
                                .rotationEffect(.degrees(-90))
                                .rotationEffect(.degrees(angle))
                            
                            Rectangle()
                                .frame(width: 1)
                                .rotationEffect(.degrees(lineAngle))
                                .opacity(0.1)
                        }
                    }
                    .rotationEffect(currentAngle + finalAngle)
                    .gesture (
                        RotationGesture()
                            .onChanged { angle in
                                currentAngle = angle
                                
                                let totalDegrees = (currentAngle + finalAngle).degrees
                                let calc = floor(totalDegrees / (360.0 / Double(characters.count)))
                                let result = Int(calc + 1) * -1
                                
                                // mod(%) of result
                                if result < 0 {
                                    self.shift = 26 + result
                                } else {
                                    self.shift = result
                                }
                            }
                            .onEnded { angle in
                                finalAngle += angle
                                currentAngle = .degrees(0)
                            }
                    )
            }
            .overlay {
                Circle()
                    .fill(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray6))
                    .frame(width: 150, height: 150)
                    .overlay {
                        Circle()
                            .strokeBorder(.quaternary, lineWidth: 1)
                    }
                    .onTapGesture {
                        shift = 0
                        withAnimation {
                            currentAngle = .degrees(0)
                            finalAngle = .degrees(-0.1)
                        }
                    }
                
                Text(shift, format: .number)
                    .font(.title3.monospaced().bold())
            }
    }
}

struct CaesarTest: View {
    @State private var shift: Int = 0
    
    var body: some View {
        CaesarWheel(shift: $shift)
    }
}

struct Caesar_Previews: PreviewProvider {
    static var previews: some View {
        CaesarTest()
    }
}
