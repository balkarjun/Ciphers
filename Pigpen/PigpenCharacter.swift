//
//  PigpenCharacter.swift
//  
//
//  Created by Arjun B on 05/04/23.
//

import SwiftUI

enum PigDirection {
    case top, right, bottom, left
}

func isPigSquare(_ character: String) -> Bool {
    let squarePigpenCharacters: Set<String> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R"]
    
    return squarePigpenCharacters.contains(character)
}

func isPigDotted(_ character: String) -> Bool {
    let dottedCharacters: Set<String> = ["J", "K", "L", "M", "N", "O", "P", "Q", "R", "W", "X", "Y", "Z"]
    
    return dottedCharacters.contains(character)
}

let PigDirections: [String : Set<PigDirection>] = [
    "A": [.right, .bottom],
    "B": [.left, .bottom, .right],
    "C": [.left, .bottom],
    "D": [.top, .right, .bottom],
    "E": [.top, .right, .bottom, .left],
    "F": [.top, .left, .bottom],
    "G": [.top, .right],
    "H": [.left, .top, .right],
    "I": [.left, .top],
    "J": [.right, .bottom],
    "K": [.left, .bottom, .right],
    "L": [.left, .bottom],
    "M": [.top, .right, .bottom],
    "N": [.top, .right, .bottom, .left],
    "O": [.top, .left, .bottom],
    "P": [.top, .right],
    "Q": [.left, .top, .right],
    "R": [.left, .top],
    "S": [.bottom],
    "T": [.right],
    "U": [.left],
    "V": [.top],
    "W": [.bottom],
    "X": [.right],
    "Y": [.left],
    "Z": [.top],
]

struct PigpenCharacter: View {
    private let character: String
    private let lineColor: Color
    
    init(_ character: String, lineColor: Color = .black) {
        self.character = character.uppercased()
        self.lineColor = lineColor
    }
    
    private let width: Double = 18
    private let height: Double = 18
    private let lineWidth: Double = 2
    private let dotSize: Double = 4
    
    private var isSpecial: Bool {
        character == " " || character == ","
    }
    
    private var isSquare: Bool {
        isPigSquare(self.character)
    }
    
    private var directions: Set<PigDirection> {
        PigDirections[self.character] ?? [.right, .bottom]
    }
    
    private var dotted: Bool {
        isPigDotted(self.character)
    }
    
    private var angularOffset: Double {
        switch (directions.first ?? .top) {
        case .top:    return 0
        case .right:  return 90
        case .bottom: return 180
        case .left:   return 270
        }
    }
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .frame(width: width, height: height)
            .overlay {
                ZStack {
                    Rectangle()
                        .fill(lineColor)
                        .frame(height: lineWidth)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .opacity(directions.contains(.top) ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        .opacity(directions.contains(.right) ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(height: lineWidth)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .opacity(directions.contains(.bottom) ? 1 : 0)
                    
                    Rectangle()
                        .fill(lineColor)
                        .frame(width: lineWidth)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .opacity(directions.contains(.left) ? 1 : 0)
                }
                .opacity(isSquare ? 1 : 0)
                .opacity(isSpecial ? 0 : 1)
            }
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(lineColor)
                        .frame(width: lineWidth)
                        .rotationEffect(.degrees(29), anchor: .top)
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(lineColor)
                        .frame(width: lineWidth)
                        .rotationEffect(.degrees(-29), anchor: .top)
                }
                .rotationEffect(.degrees(angularOffset))
                .opacity(!isSquare ? 1 : 0)
                .opacity(isSpecial ? 0 : 1)
            }
            .overlay {
                Circle()
                    .fill(lineColor)
                    .frame(width: dotSize, height: dotSize)
                    .opacity(dotted ? 1 : 0)
                    .opacity(isSpecial ? 0 : 1)
            }
            .overlay {
                Text(character)
                    .font(.title2.bold())
                    .foregroundColor(.secondary)
                    .opacity(isSpecial ? 1 : 0)
            }
    }
}

struct PigpenCharacter_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            PigpenCharacter("A")
            PigpenCharacter(",")
            PigpenCharacter(" ")
            PigpenCharacter("B")
        }
    }
}
