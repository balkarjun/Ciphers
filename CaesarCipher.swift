//
//  CaesarCipher.swift
//  Ciphers
//
//  Created by Arjun B on 11/04/23.
//

import SwiftUI

struct CaesarCipher: View {
    let encrypted = encrypt(message: "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right", shift: 17)
    let target = "Viewed through holes of light, hidden in plain sight, the clue faces left from right".uppercased()
    
    @State private var shift: Int = 0
    
    private var shifted: String {
        encrypt(message: encrypted, shift: shift)
    }
    
    var body: some View {
        VStack {
            Text(encrypted)
                .font(.body.monospaced())
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(.quaternary, lineWidth: 1)
                }
            
            Text(shifted)
                .font(.body.monospaced())
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Caesar(shift: $shift)
            Spacer()
        }
        .padding()
    }
}

struct CaesarCipher_Previews: PreviewProvider {
    static var previews: some View {
        CaesarCipher()
    }
}
