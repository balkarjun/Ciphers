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

struct ChunkedText<Content: View>: View {
    let text: String
    let limit: Double
    let content: (String) -> Content
    
    let charWidth: Double = 18
    let charHeight: Double = 18
    // space between two consecutive characters
    let kerning: Double = 6
    // space between lines
    let lineSpacing: Double = 6
    
    // number of characters that can fit in a lint
    private var lineLength: Int {
        if limit == 0 { return 1 }

        return Int(limit / (charWidth + kerning))
    }
    
    private var chunked: [[Chunk]] {
        let lines = text.split(whereSeparator: \.isNewline)
        
        var result = [[Chunk]]()
        
        for line in lines {
            let letters = line.map { String($0) }
            
            var rowText = [Chunk]()
            var count = 0
            
            for letter in letters {
                if count == 0 && letter == " " {
                    continue
                }
                
                count += 1
                rowText.append(Chunk(char: letter))
                
                // when line limit is reached
                if count % lineLength == 0 {
                    count = 0
                    result.append(rowText)
                    rowText = []
                }
            }
            
            // if last line was not already added
            if count != 0 {
                result.append(rowText)
            }
        }
        
        return result
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(chunked, id: \.self) { line in
                HStack(spacing: 0) {
                    ForEach(line, id: \.id) { chunk in
                        content(chunk.char)
                            .frame(width: charWidth, height: charHeight)
                            .padding(.horizontal, kerning/2)
                            .padding(.vertical, lineSpacing/2)
                    }
                }
            }
        }
    }
}

struct ChunkedText_Previews: PreviewProvider {
    static var previews: some View {
        ChunkedText(text: "Sphinx  of black quartz,\n judge my vow an".uppercased(), limit: 300) { char in
            PigpenCharacter(char)
                .padding(2)
        }
    }
}
