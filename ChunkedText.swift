//
//  ChunkedText.swift
//  Ciphers
//
//  Created by Arjun B on 13/04/23.
//

import SwiftUI

struct Chunk: Hashable {
    let char: String
    let id = UUID()
}

struct ChunkedText: View {
    let text: String
    let chunkSize: Int
    var charWidth: Double = 18
    var charHeight: Double = 18
    var pigpen: Bool = false
    var blocks: Bool = false
    
    var highlighted: String = ""
    var completed: Set<String> = []
    
    private var chunked: [[Chunk]] {
        var result = [[Chunk]]()
        
        var line = [Chunk]()
        var count = 0
        
        for character in text.map({ String($0) }) {
            count += 1
            if character != "\n" {
                line.append(Chunk(char: character))
            }
            
            // when line limit is reached,
            // add line to result and reset
            if count % chunkSize == 0 || character == "\n" {
                // remove leading space and
                // accomodate an additional char
                if line.first?.char == " " {
                    line.remove(at: 0)
                    count -= 1
                    if character != "\n" {
                        continue
                    }
                }
                
                count = 0
                result.append(line)
                line = []
            }
        }
        // if last line was not already appended
        if count != 0 {
            if line.first?.char == " " {
                line.remove(at: 0)
            }
            
            result.append(line)
        }
        
        return result
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(chunked, id: \.self) { line in
                HStack(spacing: 0) {
                    ForEach(line, id: \.id) { chunk in
                        let isHighlighted = (chunk.char == highlighted)
                        let isCompleted = completed.contains(chunk.char)
                        
                        ChunkedCharacter(
                            character: chunk.char,
                            width: charWidth,
                            height: charHeight,
                            pigpen: pigpen,
                            blocks: blocks,
                            highlighted: isHighlighted,
                            completed: isCompleted
                        )
                    }
                }
            }
        }
    }
}

struct ChunkedCharacter: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let character: String
    let width: Double
    let height: Double
    let pigpen: Bool
    let blocks: Bool
    
    var highlighted: Bool = false
    var completed: Bool = false
    
    // space between two consecutive characters
    private let kerning: Double = 6
    // space between rows of characters
    private let lineSpacing: Double = 6
    
    private var BlankSpaceCharacter: some View {
        Rectangle()
            .fill(.clear)
            .frame(width: width, height: height)
    }
    
    private var CommaCharacter: some View {
        Text(",")
            .font(.system(size: 25, weight: .bold))
            .frame(width: width, height: height)
            .foregroundColor(completed ? .secondary : primaryColor)
    }
    
    private var primaryColor: Color {
        colorScheme == .dark ? .white : .black
    }

    var body: some View {
        Group {
            if pigpen {
                if character == " " {
                    BlankSpaceCharacter
                } else if character == "," {
                    CommaCharacter
                } else {
                    PigpenCharacter(
                        character,
                        lineColor: completed ? .secondary : primaryColor,
                        charWidth: width,
                        charHeight: height
                    )
                    .padding(.horizontal, kerning/2)
                    .padding(.vertical, lineSpacing)
                    .background {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.accentColor.opacity(0.5))
                            .opacity(highlighted ? 1 : 0)
                    }
                }
            } else if blocks {
                let isEmpty = (character == "." || character == " ")
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: width, height: height)
                    .padding(.horizontal, kerning/2)
                    .padding(.vertical, lineSpacing)
                    .background(isEmpty ? .clear : .white)
                    .cornerRadius(2)
            } else {
                Text(character)
                    .font(.body.monospaced().weight(.semibold))
                    .frame(width: width, height: height)
                    .padding(.horizontal, kerning/2)
                    .padding(.vertical, lineSpacing)
            }
        }
    }
}

struct ChunkedText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChunkedText(text: "Sph\ninx of black qua\nrtz, judge my vow".uppercased(), chunkSize: 5, blocks: false)
        }
    }
}
