//
//  PigpenKeyboard.swift
//  
//
//  Created by Arjun B on 05/04/23.
//

import SwiftUI

struct PigpenSquareKeyboard: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var tapped: String
    
    let characters: [String]
    var dotted: Bool = false
    
    var width: Double = 200
    var height: Double = 200
    var dotSize: Double = 8
    
    private let primaryColor: Color = .primary
    
    private var backgroundColor: Color {
        Color.accentColor.opacity(colorScheme == .dark ? 0.25 : 0.1)
    }
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .frame(width: width, height: height)
            .overlay {
                ForEach(Array(characters.enumerated()), id: \.offset) { index, character in
                    let rowNumber: Int = index % 3
                    let xOffset: Double = Double(rowNumber - 1)*(width/3)
                    
                    let colNumber: Int = index / 3
                    let yOffset: Double = Double(colNumber - 1)*(height/3)

                    Button {
                        tapped = character
                    } label: {
                        ZStack {
                            Text(character)
                                .font(.title2.monospaced().bold())
                                .foregroundColor(.primary)
                                .frame(width: width/3, height: height/3)
                            
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: dotSize, height: dotSize)
                                .opacity(dotted ? 1 : 0)
                                .offset(x: width/12)
                        }
                        .background(backgroundColor)
                    }
                    .offset(x: xOffset, y: yOffset)
                }
            }
            .overlay {
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 3)
                    .offset(x: -width/6)
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 3)
                    .offset(x: width/6)
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(height: 3)
                    .offset(y: -height/6)
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(height: 3)
                    .offset(y: height/6)
            }
            .cornerRadius(12)
    }
}

struct PigpenTriangleKeyboard: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var tapped: String
    
    let characters: [String]
    var dotted: Bool = false
    
    var width: Double = 150
    var height: Double = 150
    var dotSize: Double = 8
    
    private let primaryColor: Color = .primary
    
    private var backgroundColor: Color {
        Color.accentColor.opacity(colorScheme == .dark ? 0.25 : 0.1)
    }
    
    private func dotOffset(row: Int, col: Int) -> Double {
        if row == 0 && col == 0 { return   45 }
        if row == 0 && col == 1 { return  -45 }
        if row == 1 && col == 0 { return  135 }
        if row == 1 && col == 1 { return -135 }
        
        return 0
    }
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .frame(width: width, height: height)
            .overlay {
                ForEach(Array(characters.enumerated()), id: \.offset) { index, character in
                    let rowNumber: Int = index % 2
                    let xOffset: Double = Double(rowNumber - 1)*(width/2) + width/4
                    
                    let colNumber: Int = index / 2
                    let yOffset: Double = Double(colNumber - 1)*(height/2) + height/4

                    Button {
                        tapped = character
                    } label: {
                        ZStack {
                            Text(character)
                                .font(.title2.monospaced().bold())
                                .foregroundColor(.primary)
                                .frame(width: width/2, height: height/2)
                                .rotationEffect(.degrees(-45))
                            
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: dotSize, height: dotSize)
                                .opacity(dotted ? 1 : 0)
                                .offset(x: width/6)
                                .rotationEffect(.degrees(dotOffset(row: rowNumber, col: colNumber)))
                        }
                        .background(backgroundColor)
                    }
                    .offset(x: xOffset, y: yOffset)
                }
            }
            .overlay {
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 3)
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(height: 3)
            }
            .cornerRadius(12)
            .rotationEffect(.degrees(45))
    }
}

struct PigpenKeyboard: View {
    @Binding var tapped: String
    
    var body: some View {
        VStack(spacing: 36) {
            HStack(spacing: 12) {
                PigpenSquareKeyboard(
                    tapped: $tapped,
                    characters: ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
                )
                
                PigpenSquareKeyboard(
                    tapped: $tapped,
                    characters: ["J", "K", "L", "M", "N", "O", "P", "Q", "R"],
                    dotted: true
                )
            }
            
            HStack(spacing: 64) {
                PigpenTriangleKeyboard(
                    tapped: $tapped,
                    characters: ["S", "U", "T", "V"]
                )
                
                PigpenTriangleKeyboard(
                    tapped: $tapped,
                    characters: ["W", "Y", "X", "Z"],
                    dotted: true
                )
            }
        }
    }
}

struct PigpenKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        PigpenKeyboard(tapped: .constant(""))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
