//
//  PigpenPage.swift
//  Ciphers
//
//  Created by Arjun B on 12/04/23.
//

import SwiftUI

struct PigpenPage: View {
    @EnvironmentObject var state: AppState
    
    @State private var tapped = ""
    @State private var highlighted = "F"
    @State private var completedCharacters: Set<String> = [" ", ",", "\n"]
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var solved: Bool {
        highlighted == ""
    }
    
    private var pigpenColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    private var accessibilityExplanation: String {
        "There are two types of symbols. Squares and Diamonds. Within this, there are two more types, dotted and not dotted. The letters 'A' to 'I' are squares. The letters 'J' to 'R' are dotted squares. 'S' to 'V' are diamonds and finally, 'W' to 'Z' are dotted diamonds. The square symbols have borders, but not all sides are filled. For example, the symbol for the letter 'F', has a border on the bottom, left and top. It's right side is empty. The symbol for the letter 'N' has borders on all sides and is dotted. This is how the square letters are differentiated from one another. The diamond symbols are angled. The symbol for the letter 'S' is angled to the bottom. The symbol for the letter 'X' is angled to the right and is dotted. This is how the diamond symbols are differentiated from one another. In the interactive area, you will be able to navigate through the different symbols via a custom keyboard. Simply match the correct letter to the symbol type spelled out by the header letter."
    }
    
    var body: some View {
        SplitView(page: .one, disabled: !solved) {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    PigpenText(
                        state.encrypted,
                        highlighted: highlighted,
                        completed: completedCharacters
                    )
                    .padding(24)
                    .accessibilityHidden(true)
                    
                    Rectangle()
                        .fill(.thinMaterial)
                        .frame(width: 2)
                        .accessibilityHidden(true)
                    
                    PigpenCharacter(highlighted, lineColor: pigpenColor)
                        .opacity(highlighted == "" ? 0 : 1)
                        .scaleEffect(2.5)
                        .padding(48)
                        .accessibilityAddTraits(.isHeader)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .background(.thinMaterial)
                .cornerRadius(8)
                
                InteractionPrompt(
                    title: "Match the Symbols and Letters",
                    description: "Using the keyboard in the interactive area, tap on the matching letter for the symbol highlighted above, to make sense of this cryptic message."
                )
                
                Text("This is the **Pigpen Cipher** where each letter in the message is replaced by a symbol. Here's an example:")
                    .padding()
                
                HStack(spacing: 0) {
                    ForEach(Array("FINALCUT".map{ String($0) }.enumerated()), id: \.offset) { _, char in
                        VStack(spacing: 4) {
                            PigpenCharacter(char, lineColor: pigpenColor)
                            
                            Text(char)
                                .font(.title3.monospaced().bold())
                                .foregroundColor(Color.accentColor)
                                .frame(width: 24)
                                .accessibilityLabel(char.lowercased())
                                .speechSpellsOutCharacters()
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                                
                VStack(alignment: .leading) {
                    Text("To decipher this message, we need to find the matching letter for each symbol. You can find this symbol from the lines surrounding that letter in the keyboard grid, in the interactive area to your right.")
                    
                    HStack {
                        Text("P")
                            .font(.body.bold())
                        
                        PigpenCharacter("P", lineColor: pigpenColor)
                        
                        Text("For example, the letter ***P*** is surrounded by lines to the top and to the right, and contains a dot.")
                            .padding(.leading)
                    }
                    
                    HStack {
                        Text("S")
                            .font(.body.bold())
                        
                        PigpenCharacter("S", lineColor: pigpenColor)
                        
                        Text("The letter ***S*** has angled lines to it's bottom left and bottom right.")
                            .padding(.leading)
                    }
                }
                .padding(.horizontal)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(accessibilityExplanation)
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "sparkles")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.primary)
                            .font(.body.bold())
                            .accessibilityHidden(true)
                        
                        Text("Hint")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.primary)
                    }
                    
                    Text("F is the first letter in this message. Start by pressing **F** on the keyboard in the interactive area.")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(.thinMaterial, lineWidth: 1)
                }
            }
        } trailing: {
            VStack(spacing: 0) {
                AnswerField(
                    target: state.encrypted,
                    completed: completedCharacters
                )
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(.thinMaterial, lineWidth: 2)
                }
                .accessibilityHidden(true)
                
                Spacer()
                
                PigpenKeyboard(tapped: $tapped)
                    .accessibilityAddTraits(.isHeader)

                Spacer()
                
                HStack {
                    Image(systemName: "hand.tap.fill")
                        .font(.body.bold())
                    
                    Text("Tap on the matching letter")
                        .font(.callout.monospaced())
                }
                .accessibilityHidden(true)
                .foregroundColor(.secondary)
                .padding()
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
            for character in state.encrypted.map({ String($0) }) {
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
                .font(.title3.monospaced().weight(.medium))
            
            Text(placeholder)
                .font(.title3.monospaced().weight(.medium))
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
