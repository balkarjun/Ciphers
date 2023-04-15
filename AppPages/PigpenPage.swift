//
//  PigpenPage.swift
//  Ciphers
//
//  Created by Arjun B on 12/04/23.
//

import SwiftUI

struct PigpenPage: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var state: AppState

    let target = cshift(message: "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased(), by: 10)
    
    @State private var tapped: String = ""
    @State var highlighted: String = cshift(message: "V", by: 10)
    @State private var completedCharacters: Set<String> = [" ", ",", "\n"]
    
    var body: some View {
        SplitView(page: .one, disabled: highlighted != "") {
            state.nextPage()
        } leading: {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    PigpenCharacter(
                        highlighted,
                        lineColor: colorScheme == .dark ? .white : .black
                    )
                    .scaleEffect(2.5)
                    .padding()
                    .padding()
                    .padding(.horizontal)
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
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .fixedSize(horizontal: false, vertical: true)
                
                Text("In a ***Pigpen Cipher***, each letter is replaced with a symbol, like a made-up language.")
                    .padding([.horizontal, .top])
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 6) {
                        ForEach(Array("FINALCUT".map{ String($0) }.enumerated()), id: \.offset) { _, char in
                            Text(char)
                                .frame(width: 18)
                        }
                    }
                    .font(.body.bold())
                    
                    PigpenText("FINALCUT", completed: [])
                }
                .padding()
                
                Text("To find the right symbols, use the keyboard grid to the right. The symbol for each letter is obtained from the lines surrounding that character in the grid.")
                    .padding([.horizontal, .bottom])
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "rectangle.and.hand.point.up.left.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.teal)
                            .font(.body.bold())
                        
                        Text("Match the Symbols")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.teal)
                            .offset(y: -1)
                    }
                    Text("Using the keyboard provided, tap on the matching letter for the highlighted symbol to make sense of this cryptic message.")
                    
                    Text("***Hint***: The first letter is **F**")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(.quaternary, lineWidth: 1)
                }
            }
        } trailing: {
            VStack(spacing: 0) {
                AnswerField(
                    target: target,
                    completed: completedCharacters
                )
                .padding()
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(.quaternary.opacity(0.5), lineWidth: 2)
                }
                .padding()
                Spacer()
                VStack(spacing: 24) {
                    HStack(spacing: 24) {
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
                    
                    HStack(spacing: 24) {
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
                Spacer()
            }
        }
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
    }
}

struct AnswerField: View {
    let target: String
    let completed: Set<String>
    
    private var displayedText: String {
        var result = ""
        for character in target.map({ String($0) }) {
            if character == "," {
                result += " "
            } else if completed.contains(character) {
                result += character
            } else {
                result += " "
            }
        }
        
        return result
    }
    
    private var placeholder: String {
        var result = ""
        for character in target.map({ String($0) }) {
            if character == "\n" || character == "," {
                result += character
            } else if completed.contains(character) {
                result += " "
            } else {
                result += "·"
            }
        }
        
        return result
    }
    
    var body: some View {
        ZStack {
            Text(displayedText)
                .font(.title2.monospaced())
                .fontWeight(.medium)
            
            Text(placeholder)
                .font(.title2.monospaced())
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
    }
}

struct PigpenPage_Previews: PreviewProvider {
    static var previews: some View {
        PigpenPage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
    }
}
