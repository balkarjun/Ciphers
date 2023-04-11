//
//  GrilleCipher.swift
//  Ciphers
//
//  Created by Arjun B on 11/04/23.
//

import SwiftUI

struct GrilleCipher: View {
    @State private var answer: String = ""
    var body: some View {
        VStack {
            Grille()
                .padding()
                .padding()
            
            TextField("", text: $answer)
                .font(.body.monospaced())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.characters)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(.quaternary, lineWidth: 1)
                }
                .padding()
        }
        .padding()
    }
}

struct GrilleCipher_Previews: PreviewProvider {
    static var previews: some View {
        GrilleCipher()
    }
}
