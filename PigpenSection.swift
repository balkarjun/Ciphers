//
//  PigpenSection.swift
//  Ciphers
//
//  Created by Arjun B on 05/04/23.
//

import SwiftUI

struct PigpenSection: View {
    @State var tapped: String = ""
    @State var highlighted: String = "V"
    @State var completedCharacters: Set<String> = [" ", ","]
    
    let target = "Viewed through holes of light, hidden in plain sight, the clue faces left from right".uppercased()
    
    var body: some View {
        ScrollView {
            VStack {                    
                    PigpenText(
                        target,
                        highlighted: highlighted,
                        replaced: Set<String>()
                    )
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .strokeBorder(.quaternary.opacity(0.5), lineWidth: 1)
                    }
                    PigpenText(
                        target,
                        highlighted: "",
                        replaced: completedCharacters,
                        lineColor: .clear
                    )
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .strokeBorder(.quaternary.opacity(0.5), lineWidth: 1)
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 24) {
                        PigpenSquareKeyboard(
                            tapped: $tapped,
                            characters: ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
                        )
                        
                        VStack(spacing: 24) {
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
                        
                        PigpenSquareKeyboard(
                            tapped: $tapped,
                            characters: ["J", "K", "L", "M", "N", "O", "P", "Q", "R"],
                            dotted: true
                        )
                    }
                    
                    Spacer()
                }
                .padding()
                .onChange(of: tapped) { _ in
                    // check if the correct character was entered
                    if tapped != highlighted {
                        tapped = ""
                        return
                    }
                    
                    // add the character to the completed set
                    completedCharacters.insert(tapped)
                    
                    // skip until next unseen character is reached. highlight that
                    var found = false
                    for character in target.map({ String($0) }) {
                        if !completedCharacters.contains(character) {
                            highlighted = character
                            found = true
                            break
                        }
                    }
                    
                    // if all characters were skipped, the solution is complete
                    if !found {
                        highlighted = ""
                    }
                    
                    tapped = ""
                }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PigpenSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PigpenSection()
        }
        .navigationViewStyle(.stack)
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
