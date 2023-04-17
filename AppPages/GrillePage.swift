//
//  GrillePage.swift
//  Ciphers
//
//  Created by Arjun B on 13/04/23.
//

import SwiftUI

struct GrillePage: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        SplitView(page: .three, disabled: false) {
            VStack(alignment: .leading) {
                Text(state.decrypted)
                    .font(.title3.monospaced())
                    .fontWeight(.medium)
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial)
                    .cornerRadius(8)
                
                InteractionPrompt(
                    title: "Find the Secret Keyword",
                    description: "Align the stencil with the text to uncover the secret keyword. Once you find it, type it into the text field."
                )
                
                Text("The message is now readable, but how do we find the secret key? The secret keyword might lie within this message, hidden in plain sight.\n\nThis is called Steganography, and the message above uses in particular a ***Grille Cipher***, where the secret becomes visible when the message is viewed through a stencil or a piece paper with holes in it.\n\nWe simply need to view the message using the given stencil, and decode it to find the secret keyword.")
                    .padding()
                
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
                    
                    Text("Make sure you read what the message says. It holds the clue to finding the secret keyword.")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(.thinMaterial, lineWidth: 1)
                }
            }
        } trailing: {
            VStack {
                GrilleText()
                    .padding()
                
                Spacer()
                
                HStack {
                    Image(systemName: "hand.point.up.left.fill")
                        .font(.body.bold())
                    
                    Text("Touch and drag the stencil around")
                        .font(.callout.monospaced())
                }
                .foregroundColor(.secondary)
                .padding()
            }
        }
    }
}

struct GrillePage_Previews: PreviewProvider {
    static var previews: some View {
        GrillePage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
    }
}
