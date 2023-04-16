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
                
                Text("A cipher is a way to disguise a message and conceal it's meaning. Hidden within the cryptic message above is a secret keyword that we're interested in.\n\nThrough a series of interactive tutorials, we will learn about the various ciphers that were used to encode this message, and decode it one step at a time until we find the hidden keyword.\n\nPress the **start** button to begin!")
                    .padding()
            }
        } trailing: {
            VStack {
                Image(systemName: "rectangle.and.hand.point.up.left.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.teal)
                    .font(.system(size: 60))
                    .padding(.bottom)
                
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
