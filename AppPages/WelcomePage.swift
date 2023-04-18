//
//  WelcomePage.swift
//  Ciphers
//
//  Created by Arjun B on 11/04/23.
//

import SwiftUI

struct WelcomePage: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        SplitView(page: .zero, disabled: false) {
            VStack(alignment: .leading) {
                PigpenText(state.encrypted)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(8)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("A cryptic message where the letters have been replaced by symbols.")
                
                Text("A cipher is a way to disguise a message and conceal it's meaning. Hidden within the cryptic message above is a secret keyword that we're interested in.\n\nThrough a series of interactive tutorials, we will learn about the various ciphers that were used to encode this message and decode it one step at a time to find the hidden keyword.")
                    .padding()
                
                HStack {
                    Text("Press the **start** button to begin")

                    Image(systemName: "arrow.right.circle.fill")
                        .font(.body.bold())
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(Color.accentColor)
                        .accessibilityHidden(true)
                }
                .padding(.horizontal)
            }
        } trailing: {
            VStack {
                Image(systemName: "rectangle.and.hand.point.up.left.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 60))
                    .padding(.bottom)
                    .accessibilityHidden(true)
                
                Text("Interactive Area")
                    .font(.body.weight(.semibold))
                Text("Tools to solve the cipher will be presented here")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
    }
}
