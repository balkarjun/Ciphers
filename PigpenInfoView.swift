//
//  PigpenInfoView.swift
//  Ciphers
//
//  Created by Arjun B on 11/04/23.
//

import SwiftUI

struct PigpenInfoView: View {
    let exampleText: String = "APP STORE"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("A Pigpen Cipher is a simple substitution cipher, where each character in the english alphabet, is replaced with a symbol, like a made-up alphabet.")
            
            VStack(alignment: .center, spacing: 0) {
                HStack(spacing: 8) {
                    ForEach(Array(exampleText.map{ String($0) }.enumerated()), id: \.offset) { _, char in
                        Text(char)
                            .frame(width: 20)
                    }
                }
                .font(.body.bold())
                
                PigpenText(exampleText, completed: [])
            }
            .padding()
            .padding(.bottom)
            
            Divider()
            
            Text("To find the right symbols, we use the below grid. The symbol for each character is obtained from the lines surrounding that character in the grid.")
            
            HStack(spacing: 24) {
                PigpenSquareKeyboard(
                    tapped: .constant(""),
                    characters: ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
                )
                
                PigpenSquareKeyboard(
                    tapped: .constant(""),
                    characters: ["J", "K", "L", "M", "N", "O", "P", "Q", "R"],
                    dotted: true
                )

                PigpenTriangleKeyboard(
                    tapped: .constant(""),
                    characters: ["S", "T", "U", "V"]
                )
                
                PigpenTriangleKeyboard(
                    tapped: .constant(""),
                    characters: ["W", "X", "Y", "Z"],
                    dotted: true
                )
            }
            .frame(maxWidth: .infinity)
            .allowsHitTesting(false)
            .padding(.vertical)
            .padding(.bottom)
            
            VStack {
                HStack {
                    VStack(spacing: 0) {
                        Text("A")
                            .font(.body.bold())
                        
                        PigpenText("A", completed: [])
                            .frame(alignment: .leading)
                    }
                    
                    Rectangle()
                        .fill(.quaternary)
                        .frame(width: 2)
                        .padding(.horizontal)
                    
                    Text("A has lines to the right and bottom")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    VStack(spacing: 0) {
                        Text("S")
                            .font(.body.bold())
                        
                        PigpenText("S", completed: [])
                            .frame(alignment: .leading)
                    }
                    
                    Rectangle()
                        .fill(.quaternary)
                        .frame(width: 2)
                        .padding(.horizontal)
                    
                    Text("S has two lines in the shape of a V")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    VStack(spacing: 0) {
                        Text("M")
                            .font(.body.bold())
                        
                        PigpenText("M", completed: [])
                            .frame(alignment: .leading)
                    }
                    
                    Rectangle()
                        .fill(.quaternary)
                        .frame(width: 2)
                        .padding(.horizontal)
                    
                    Text("M has lines to the top, right and bottom, and a dot (to differentiate it from D)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
}

struct PigpenInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PigpenInfoView()
    }
}
