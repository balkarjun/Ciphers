//
//  Pigpen.swift
//  Ciphers
//
//  Created by Arjun B on 01/04/23.
//

import SwiftUI

enum PigDirection {
    case top, right, bottom, left
}

enum PigType {
    case square, triangle
}

struct CharacterInfo: Hashable {
    let type: PigType
    let directions: Set<PigDirection>
    let dotted: Bool
    let label: String
}

struct PigpenCharacter: View {
    private let info: CharacterInfo
    
    init(_ info: CharacterInfo) {
        self.info = info
    }
    
    private var type: PigType {
        info.type
    }
    
    private var directions: Set<PigDirection> {
        info.directions
    }
    
    private var dotted: Bool {
        info.dotted
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
            .fill(.black.opacity(0.1))
            .frame(width: 80, height: 80)
            .overlay {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                        .frame(height: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .opacity(directions.contains(.top) ? 1 : 0)
                    
                    Rectangle()
                        .fill(.secondary)
                        .frame(width: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        .opacity(directions.contains(.right) ? 1 : 0)
                    
                    Rectangle()
                        .fill(.secondary)
                        .frame(height: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .opacity(directions.contains(.bottom) ? 1 : 0)
                    
                    Rectangle()
                        .fill(.secondary)
                        .frame(width: 3)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .opacity(directions.contains(.left) ? 1 : 0)
                }
                .opacity(type == .square ? 1 : 0)
            }
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(.secondary)
                        .frame(width: 3)
                        .rotationEffect(.degrees(29), anchor: .top)
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(.secondary)
                        .frame(width: 3)
                        .rotationEffect(.degrees(-29), anchor: .top)
                }
                .rotationEffect(.degrees(angularOffset))
                .opacity(type == .triangle ? 1 : 0)
            }
            .overlay {
                Circle()
                    .fill(.secondary)
                    .frame(width: 5, height: 5)
                    .opacity(dotted ? 1 : 0)
            }
    }
}

struct PigpenSquareKeyboard: View {
    @Binding var tapped: String
    
    let characters: [String]
    
    var body: some View {
        Rectangle()
            .fill(.quaternary)
            .frame(width: 300, height: 300)
            .overlay {
                ForEach(Array(characters.enumerated()), id: \.offset) { index, character in
                    let rowNumber: Int = index % 3
                    let xOffset: Double = -100.0 + Double(rowNumber)*100.0
                    let colNumber: Int = index / 3
                    let yOffset: Double = -100.0 + Double(colNumber)*100.0

                    Button {
                        tapped = character
                    } label: {
                        Text(character)
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .foregroundColor(.primary)
                            .frame(width: 100, height: 100)
                    }
                    .offset(x: xOffset, y: yOffset)
                }
            }
            .overlay {
                Rectangle()
                    .fill(.secondary)
                    .frame(width: 3)
                    .offset(x: -50)
                Rectangle()
                    .fill(.secondary)
                    .frame(width: 3)
                    .offset(x: 50)
                Rectangle()
                    .fill(.secondary)
                    .frame(height: 3)
                    .offset(y: -50)
                Rectangle()
                    .fill(.secondary)
                    .frame(height: 3)
                    .offset(y: 50)
            }
    }
}

struct PigpenTriangleKeyboard: View {
    @Binding var tapped: String
    let characters: [String]
    
    func getOffset(for index: Int) -> CGSize {
        if index == 0 { return CGSize(width: 0, height: -80)}
        if index == 1 { return CGSize(width: -80, height: 0)}
        if index == 2 { return CGSize(width: 80, height: 0)}
        return CGSize(width: 0, height: 80)
    }
    
    var body: some View {
        Rectangle()
            .fill(.quaternary)
            .frame(width: 300, height: 300)
            .overlay {
                ForEach(Array(characters.enumerated()), id: \.offset) { index, character in
                    let offset = getOffset(for: index)
                    
                    Button {
                        tapped = character
                    } label: {
                        Text(character)
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .foregroundColor(.primary)
                            .rotationEffect(.degrees(-45))
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(45))
                    }
                    .offset(offset)
                }
            }
            .overlay {
                Rectangle()
                    .fill(.secondary)
                    .frame(width: 3)
                    .rotationEffect(.degrees(-45))
                Rectangle()
                    .fill(.secondary)
                    .frame(width: 3)
                    .rotationEffect(.degrees(45))
            }
    }
}

struct Pigpen: View {
    @State var tapped: String = " "
    var body: some View {
        VStack {
            Text(tapped)
            PigpenSquareKeyboard(
                tapped: $tapped,
                characters: ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
            )
            
            PigpenTriangleKeyboard(
                tapped: $tapped,
                characters: ["S", "T", "U", "V"]
            )
        }
    }
}

struct Pigpen_Previews: PreviewProvider {
    static var previews: some View {
        Pigpen()
    }
}
