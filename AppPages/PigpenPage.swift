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
                
                InteractionPrompt(
                    symbol: "rectangle.and.hand.point.up.left.fill",
                    title: "Match the Symbols",
                    description: "Using the keyboard in the interactive area, tap on the matching letter for the symbols highlighted above, to make sense of this cryptic message."
                )
                
                Text("These funny looking symbols come from the ***Pigpen Cipher***, where each letter in the message is replaced by a symbol. Here's an example:")
                    .padding()
                
                HStack(spacing: 0) {
                    ForEach(Array("FINALCUT".map{ String($0) }.enumerated()), id: \.offset) { _, char in
                        VStack(spacing: 0) {
                            Text(char)
                                .frame(width: 18)
                                .padding(.horizontal, 3)
                                .font(.body.bold())
                            
                            PigpenCharacter(char, lineColor: .teal)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                
                Text("To decode this message, we need to find the matching letter for each symbol. You can find the symbol for each letter from the lines surrounding that letter in the keyboard grid, in the interactive area to your right.")
                    .padding(.horizontal)
                
                HStack {
                    HStack {
                        Text("P")
                            .font(.body.bold())
                        
                        PigpenCharacter("P")
                    }
                    .padding(.horizontal)
                    
                    Text("For example, the letter ***P*** is surrounded by lines to the top and to the right, and also contains a circular dot.")
                }
                .padding(.horizontal)
                
                HStack {
                    HStack {
                        Text("S")
                            .font(.body.bold())
                        
                        PigpenCharacter("S")
                    }
                    .padding(.horizontal)
                    
                    Text("The letter ***S*** has angled lines to it's bottom left and bottom right.")
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "sparkles")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.primary)
                            .font(.body.bold())
                        
                        Text("Hint")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.primary)
                    }
                    
                    Text("The first letter in the message is ***F***, so start by tapping on the letter F in the keyboard grid in the interactive area.")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(.quaternary, lineWidth: 1)
                }

                Spacer()
            }
        } trailing: {
            VStack(spacing: 0) {
                AnswerField(
                    target: target,
                    completed: completedCharacters
                )
                .padding()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(.quaternary.opacity(0.5), lineWidth: 2)
                }
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
                
                HStack {
                    Image(systemName: "hand.tap.fill")
                        .font(.body.bold())
                    
                    Text("Tap on the matching letter")
                        .font(.callout.monospaced())
                }
                .padding()
                .foregroundColor(.secondary)
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
                .font(.title3.monospaced())
                .fontWeight(.medium)
            
            Text(placeholder)
                .font(.title3.monospaced())
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
