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
                    
                    Rectangle()
                        .fill(.thinMaterial)
                        .frame(width: 2)
                    
                    PigpenCharacter(highlighted, lineColor: pigpenColor)
                        .opacity(highlighted == "" ? 0 : 1)
                        .scaleEffect(2.5)
                        .padding(48)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .background(.thinMaterial)
                .cornerRadius(8)
                
                InteractionPrompt(
                    title: "Match the Symbols and Letters",
                    description: "Using the keyboard in the interactive area, tap on the matching letter for the symbol highlighted above, to make sense of this cryptic message."
                )
                
                Text("This is the **Pigpen Cipher** in which each letter in the message is replaced by a symbol. Here's an example:")
                    .padding()
                
                HStack(spacing: 0) {
                    ForEach(Array("FINALCUT".map{ String($0) }.enumerated()), id: \.offset) { _, char in
                        VStack(spacing: 4) {
                            PigpenCharacter(char, lineColor: pigpenColor)
                            
                            Text(char)
                                .font(.title3.monospaced().bold())
                                .foregroundColor(Color.accentColor)
                                .frame(width: 24)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                
                Text("To decode this message, we need to find the matching letter for each symbol. You can find the symbol for each letter from the lines surrounding that letter in the keyboard grid, in the interactive area to your right.")
                    .padding(.horizontal)
                
                HStack {
                    Text("P")
                        .font(.body.bold())
                    
                    PigpenCharacter("P", lineColor: pigpenColor)
                    
                    Text("For example, the letter ***P*** is surrounded by lines to the top and to the right, and also contains a circular dot.")
                        .padding(.leading)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("S")
                        .font(.body.bold())
                    
                    PigpenCharacter("S", lineColor: pigpenColor)
                    
                    Text("The letter ***S*** has angled lines to it's bottom left and bottom right.")
                        .padding(.leading)
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
                
                Spacer()
                
                PigpenKeyboard(tapped: $tapped)
                
                Spacer()
                
                HStack {
                    Image(systemName: "hand.tap.fill")
                        .font(.body.bold())
                    
                    Text("Tap on the matching letter")
                        .font(.callout.monospaced())
                }
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
