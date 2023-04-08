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
        VStack {
            HStack(spacing: 16) {
                PigpenCharacter(
                    highlighted,
                    charWidth: 80,
                    charHeight: 80
                )
                .padding()
                .padding(.leading)
                .opacity(highlighted == "" ? 0 : 1)
                
                Rectangle()
                    .fill(.quaternary.opacity(0.5))
                    .frame(width: 2)
                
                PigpenText(
                    target,
                    highlighted: highlighted,
                    completed: completedCharacters
                )
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(.quaternary.opacity(0.5), lineWidth: 2)
            }
            
            AnswerField(
                target: target,
                completed: completedCharacters
            )
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(.quaternary.opacity(0.5), lineWidth: 2)
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

struct AnswerField: View {
    let target: String
    let completed: Set<String>
    
    private var displayedText: String {
        var result = ""
        for character in target.map({ String($0) }) {
            if completed.contains(character) {
                result += character
            } else {
                result += "—"
            }
        }
        
        return result
    }
    
    var body: some View {
        Text(displayedText)
            .font(.title3.monospaced())
            .fontWeight(.medium)
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
