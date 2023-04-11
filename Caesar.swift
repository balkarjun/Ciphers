//
//  Caesar.swift
//  Ciphers
//
//  Created by Arjun B on 31/03/23.
//

import SwiftUI

struct Caesar: View {
    let characters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    @State private var currentAngle: Angle = .degrees(0)
    @State private var finalAngle: Angle = .degrees(-0.1)
    
    @Binding var shift: Int

    var body: some View {
        Circle()
            .fill(.quaternary)
            .frame(width: 360, height: 360)
            .overlay {
                ForEach(Array(characters.enumerated()), id: \.offset) { index, char in
                    let angle = Double(index) * (360.0 / Double(characters.count))
                    let numericalOffset: Double = Double(index) - 0.5
                    let lineAngle = numericalOffset * (360.0 / Double(characters.count))
                    
                    Text(char)
                        .font(.system(size: 16, weight: .semibold, design: .serif))
                        .rotationEffect(.degrees(90))
                        .offset(x: 150 + 16)
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
                    .fill(Color(red: 193/255, green: 193/255, blue: 195/255))
                    .frame(width: 300, height: 300)
                    .overlay {
                        ForEach(Array(characters.enumerated()), id: \.offset) { index, char in
                            let angle: Double = Double(index) * (360.0 / Double(characters.count))
                            let numericalOffset: Double = Double(index) - 0.5
                            let lineAngle: Double = numericalOffset * (360.0 / Double(characters.count))

                            Text(char)
                                .font(.system(size: 16, weight: .semibold, design: .serif))
                                .rotationEffect(.degrees(90))
                                .offset(x: 150 - 12)
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
    }
}

func encrypt(message: String, shift: Int) -> String {
    func shiftLetter(ucs: UnicodeScalar) -> UnicodeScalar {
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("Z").value)
        let letterCount = lastLetter - firstLetter + 1
        
        let value = Int(ucs.value)
        switch value {
        case firstLetter...lastLetter:
            // Offset relative to first letter:
            var offset = value - firstLetter
            // Apply shift amount (can be positive or negative):
            offset += shift
            // Transform back to the range firstLetter...lastLetter:
            offset = (offset % letterCount + letterCount) % letterCount
            // Return corresponding character:
            return UnicodeScalar(firstLetter + offset)!
        default:
            // Not in the range A...Z, leave unchanged:
            return ucs
        }
    }
    
    let shifted = message.uppercased().unicodeScalars.map(shiftLetter)
    return String(String.UnicodeScalarView(shifted))
}

struct Caesar_Previews: PreviewProvider {
    static var previews: some View {
        Caesar(shift: .constant(0))
    }
}
