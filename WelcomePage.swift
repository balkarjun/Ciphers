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
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "0.circle.fill")
                        .font(.body.weight(.bold))
                        .foregroundColor(.teal)
                    
                    Text("Introduction")
                        .font(.body.weight(.semibold))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.mint.opacity(0.15))
                .cornerRadius(8)
                
                ScrollView {
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
                    .padding(.top, 12)
                }
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(.mint.opacity(0.2), lineWidth: 1)
                    .overlay {
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
                        .padding()
                    }
                
                Button(action: state.nextPage) {
                    HStack {
                        Text("Next")
                            .font(.body.bold())
                        Spacer()
                        Image(systemName: "arrow.right")
                            .font(.body.bold())
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.teal)
            }
            .frame(maxHeight: .infinity)
        }
        .padding()
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
    }
}
