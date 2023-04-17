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
    
    private var isNextPageDisabled: Bool {
        shifted != state.decrypted
    }
    
    var body: some View {
        SplitView(page: .two, disabled: isNextPageDisabled) {
            VStack(alignment: .leading) {
                Text(state.encrypted)
                    .font(.title3.monospaced())
                    .fontWeight(.medium)
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial)
                    .cornerRadius(8)
                
                InteractionPrompt(
                    title: "Decipher the Message",
                    description: "Turn the wheel in the interactive area to shift each letter in the message, until it becomes readable."
                )
                
                Text("We've replaced the pigpen symbols with their matching letters, but the message still doesn't make sense.\n\nThat's because this message is encoded using a ***Caesar Cipher***, where each letter is replaced by another letter some fixed number of positions down the alphabet. Here's an example:")
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("APPLE")
                            .font(.title3.monospaced().weight(.semibold))
                        
                        Text(cshift(message: "APPLE", by: 1))
                            .font(.title3.monospaced().weight(.semibold))
                            .foregroundColor(.teal)
                    }
                    .padding(.leading)
                    
                    Text("Here, each letter of the word ***APPLE*** is shifted by **1** position.\nA is shifted to B, L is shifted to M, and so on..")
                        .padding(.horizontal)
                }
                
                Text("To decode the message, we simply shift it back by the same number of positions.")
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
                
                Spacer()
                
                CaesarWheel(shift: $shift)
                
                Spacer()
                
                HStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.body.bold())
                    
                    Text("Use two fingers to rotate the inner wheel, or use the arrows. Tap the center to reset.")
                        .font(.callout.monospaced())
                }
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
