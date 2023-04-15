//
//  WelcomePage.swift
//  Ciphers
//
//  Created by Arjun B on 11/04/23.
//

import SwiftUI

struct WelcomePage: View {
    let target = cshift(message: "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased(), by: 10)
    
    var body: some View {
        SplitView(page: .zero, disabled: false) {
            VStack(alignment: .leading) {
                PigpenText(target)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                
                Text("A ***cipher*** is a way to disguise a message and conceal it's meaning. Hidden within the cryptic message above, is a secret keyword that we're interested in.\n\nThrough a series of interactive tutorials, you will learn about the various ciphers that were used to encode this message, and decode it one step at a time, until you find the hidden keyword.")
                    .padding()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Part 1")
                            .font(.body.weight(.semibold).monospacedDigit())
                            .foregroundColor(.secondary)
                        Text("Pigpen Cipher")
                            .font(.body.weight(.semibold))
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(.thinMaterial, lineWidth: 1)
                    }
                    
                    HStack {
                        Text("Part 2")
                            .font(.body.weight(.semibold).monospacedDigit())
                            .foregroundColor(.secondary)
                        Text("Caesar Cipher")
                            .font(.body.weight(.semibold))
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(.thinMaterial, lineWidth: 1)
                    }
                    
                    HStack {
                        Text("Part 3")
                            .font(.body.weight(.semibold).monospacedDigit())
                            .foregroundColor(.secondary)
                        Text("Grille Cipher")
                            .font(.body.weight(.semibold))
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(.thinMaterial, lineWidth: 1)
                    }
                }
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
                Text("Here, you'll get various tools to solve the cipher")
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
    }
}
