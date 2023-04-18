//
//  CaesarPage.swift
//  Ciphers
//
//  Created by Arjun B on 13/04/23.
//

import SwiftUI

struct CaesarPage: View {
    @EnvironmentObject var state: AppState
    
    @State private var shift: Int = 0
    
    private var shifted: String {
        cshift(message: state.encrypted, by: shift)
    }
    
    private var solved: Bool {
        shifted == state.decrypted
    }
    
    private var encryptedTextAccessibilityLabel: String {
        state.encrypted.lowercased().replacingOccurrences(of: "\n", with: " ")
    }
    
    private var shiftedTextAccessibilityLabel: String {
        if solved {
            return shifted
        }
        
        return shifted.lowercased().replacingOccurrences(of: "\n", with: " ")
    }
    
    var body: some View {
        SplitView(page: .two, disabled: !solved) {
            VStack(alignment: .leading) {
                Text(state.encrypted)
                    .font(.title3.monospaced().weight(.medium))
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial)
                    .cornerRadius(8)
                    .accessibilityLabel(encryptedTextAccessibilityLabel)
                    .speechSpellsOutCharacters()
                
                InteractionPrompt(
                    title: "Decipher the Message",
                    description: "Turn the wheel in the interactive area to shift each letter in the message, until it becomes readable."
                )
                
                Text("We've replaced the pigpen symbols with their matching letters, but the message still doesn't make sense.\n\nThat's because this message is encoded using a ***Caesar Cipher***, where each letter is replaced by some other letter a fixed number of positions down the alphabet. Here's an example:")
                .padding()
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("APPLE")
                            .font(.title3.monospaced().weight(.semibold))
                            .accessibilityLabel("apple")
                            .speechSpellsOutCharacters()
                        
                        Text(cshift(message: "APPLE", by: 1))
                            .font(.title3.monospaced().weight(.semibold))
                            .foregroundColor(Color.accentColor)
                            .accessibilityLabel(cshift(message: "APPLE", by: 1).lowercased())
                            .speechSpellsOutCharacters()
                    }
                    .accessibilityElement(children: .combine)
                    
                    Text("Here, each letter of the word APPLE is shifted by 1 position.\n**A** is shifted to **B**, **L** is shifted to **M**, and so on..")
                }
                .padding(.horizontal)
                
                Text("To decipher this message, we simply shift it back by the same number of positions.")
                    .padding()
            }
        } trailing: {
            VStack {
                Text(shifted)
                    .font(.title3.monospaced().weight(.medium))
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .strokeBorder(.thinMaterial, lineWidth: 2)
                    }
                    .animation(.none, value: shifted)
                    .accessibilityLabel(shiftedTextAccessibilityLabel)
                    .speechSpellsOutCharacters(!solved)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                
                CaesarWheel(shift: $shift)
                
                Spacer()
                
                HStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.body.bold())
                    
                    Text("Use two fingers to rotate the inner wheel, or use the arrows. Tap the center to reset.")
                        .font(.callout.monospaced())
                }
                .accessibilityHidden(true)
                .foregroundColor(.secondary)
                .padding()
            }
        }
    }
}

struct CaesarPage_Previews: PreviewProvider {
    static var previews: some View {
        CaesarPage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
    }
}
