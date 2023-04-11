//
//  PigpenKeyboard.swift
//  
//
//  Created by Arjun B on 05/04/23.
//

import SwiftUI

struct PigpenSquareKeyboard: View {
    @Binding var tapped: String
    
    let characters: [String]
    var dotted: Bool = false
    
    var width: Double = 160
    var height: Double = 160
    var dotSize: Double = 7
    
    private let primaryColor: Color = .primary
    
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
                                .font(.title2.bold().monospaced())
                                .foregroundColor(.primary)
                                .frame(width: width/3, height: height/3)
                            
                            Circle()
                                .fill(primaryColor.opacity(0.8))
                                .frame(width: dotSize, height: dotSize)
                                .opacity(dotted ? 1 : 0)
                                .offset(x: width/12)
                        }
                        .background(Color.accentColor.opacity(0.1))
                    }
                    .offset(x: xOffset, y: yOffset)
                }
            }
            .overlay {
                Rectangle()
                    .fill(Color.accentColor.opacity(0.7))
                    .frame(width: 3)
                    .offset(x: -width/6)
                Rectangle()
                    .fill(Color.accentColor.opacity(0.7))
                    .frame(width: 3)
                    .offset(x: width/6)
                Rectangle()
                    .fill(Color.accentColor.opacity(0.7))
                    .frame(height: 3)
                    .offset(y: -height/6)
                Rectangle()
                    .fill(Color.accentColor.opacity(0.7))
                    .frame(height: 3)
                    .offset(y: height/6)
            }
            .cornerRadius(12)
    }
}

struct PigpenTriangleKeyboard: View {
    @Binding var tapped: String
    let characters: [String]
    var dotted: Bool = false
    
    var width: Double = 160
    var height: Double = 160
    var dotSize: Double = 8
    
    func getOffset(for index: Int) -> CGSize {
        if index == 0 { return CGSize(width: 0, height: -height/3.5)}
        if index == 1 { return CGSize(width: -width/3.5, height: 0)}
        if index == 2 { return CGSize(width: width/3.5, height: 0)}
        return CGSize(width: 0, height: height/3.5)
    }
    
    func getDotOffset(for index: Int) -> CGSize {
        if index == 0 { return CGSize(width: 0, height: 32)}
        if index == 1 { return CGSize(width: 32, height: 0)}
        if index == 2 { return CGSize(width: -32, height: 0)}
        return CGSize(width: 0, height: -32)
    }
    
    private let primaryColor: Color = .primary

    var body: some View {
        Rectangle()
            .fill(.clear)
            .frame(width: width, height: height)
            .overlay {
                ForEach(Array(characters.enumerated()), id: \.offset) { index, character in
                    let offset = getOffset(for: index)
                    let dotOffset = getDotOffset(for: index)
                    
                    Button {
                        tapped = character
                    } label: {
                        ZStack {
                            Text(character)
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                                .rotationEffect(.degrees(-45))
                                .frame(width: width*1.1/3, height: height*1.1/3)
                            
                            Circle()
                                .fill(primaryColor.opacity(0.8))
                                .frame(width: dotSize, height: dotSize)
                                .opacity(dotted ? 1 : 0)
                                .offset(dotOffset)
                                .rotationEffect(.degrees(-45))
                        }
                        .background(Color.accentColor.opacity(0.1))
                        .rotationEffect(.degrees(45))
                    }
                    .offset(offset)
                }
            }
            .overlay {
                Rectangle()
                    .fill(Color.accentColor.opacity(0.7))
                    .frame(width: 3, height: height/1.25)
                    .rotationEffect(.degrees(-45))
                Rectangle()
                    .fill(Color.accentColor.opacity(0.7))
                    .frame(width: 3, height: height/1.25)
                    .rotationEffect(.degrees(45))
            }
            .cornerRadius(8)
    }
}

struct PigpenKeyboard: View {
    @State private var tapped: String = ""
    
    var body: some View {
        VStack {
            HStack {
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
            
            HStack {
                PigpenTriangleKeyboard(
                    tapped: $tapped,
                    characters: ["S", "T", "U", "V"]
                )
                
                PigpenTriangleKeyboard(
                    tapped: $tapped,
                    characters: ["W", "X", "Y", "Z"],
                    dotted: true
                )
            }
        }
    }
}

struct PigpenKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        PigpenKeyboard()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
