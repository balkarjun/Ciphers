//
//  WelcomePage.swift
//  Ciphers
//
//  Created by Arjun B on 11/04/23.
//

import SwiftUI

struct WelcomePage: View {
    @EnvironmentObject var state: AppState
    
    let target = cshift(message: "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased(), by: 10)
    
    var body: some View {
        SplitView(page: .zero, disabled: false) {
            state.nextPage()
        } leading: {
            VStack(alignment: .leading) {
                Text("A ***cipher*** is a way to disguise a message and conceal it's meaning.")
                    .padding()
                
                PigpenText(target)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                
                Text("This cryptic message above contains a secret key that we're interested in.")
                    .padding()
                
                Text("Through these series of tutorials, you will learn about some of the various ciphers used throughout history and uncover the hidden message one step at a time.")
                    .padding([.horizontal, .bottom])
                
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
            .environmentObject(AppState())
    }
}
