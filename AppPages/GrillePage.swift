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
                    .accessibilityAddTraits(.isHeader)
                
                InteractionPrompt(
                    title: "Find the Secret Keyword",
                    description: "Align the stencil with the text to uncover the keyword. Once you find it, type it into the text field."
                )
                
                Text("The message is now readable, but how do we find the secret keyword? It is hidden in the message itself.\n\nThis is called Steganography, and the message above uses a ***Grille Cipher***, where the secret becomes visible when the message is viewed through a stencil or a piece of paper with holes in it.\n\nWe simply need to view the message using the stencil, and decipher it by reading out the highlighted letters.")
                    .padding()
                
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
                    
                    Text("Pay attention to what the message says.")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(.thinMaterial, lineWidth: 1)
                }
            }
        } trailing: {
            VStack(spacing: 0) {
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
                .accessibilityHidden(true)
                
                HStack {
                    Image(systemName: "hand.point.up.left")
                        .font(.body.bold())
                        .rotationEffect(.degrees(-180))
                    
                    Text("Type the secret keyword here")
                        .font(.callout.monospaced())
                }
                .foregroundColor(.secondary)
                .padding()
                .accessibilityHidden(true)
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
