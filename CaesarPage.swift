//
//  CaesarPage.swift
//  Ciphers
//
//  Created by Arjun B on 13/04/23.
//

import SwiftUI

struct CaesarPage: View {
    @EnvironmentObject var state: AppState
    
    let encrypted = encrypt(message: "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased(), shift: 10)
    
    let target = "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased()
    
    @State private var shift: Int = 0
    
    private var shifted: String {
        encrypt(message: encrypted, shift: shift)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "2.circle.fill")
                        .font(.body.weight(.bold))
                        .foregroundColor(.teal)
                    
                    Text("Caesar Cipher")
                        .font(.body.weight(.semibold))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.mint.opacity(0.15))
                .cornerRadius(8)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(encrypted)
                            .font(.title3.monospaced())
                            .fontWeight(.medium)
                            .padding()
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.ultraThinMaterial)
                            .cornerRadius(8)
                        
                        Text("In a ***Caesar Cipher***, each letter is replaced by a letter a fixed number of positions down the alphabet.")
                            .padding()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("APPLE")
                                    .font(.title3.monospaced().weight(.semibold))
                                Text(encrypt(message: "APPLE", shift: 1))
                                    .font(.title3.monospaced().weight(.semibold))
                                    .foregroundColor(.teal)
                            }
                            .padding(.leading)
                            
                            Text("Here, each letter of the word ***APPLE*** is shifted by **1** position.\nA is shifted to B, L is shifted to M, and so on..")
                                .padding(.horizontal)
                        }
                        
                        Text("The encrypted message above seems to be shifted by some unknown amount.")
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Image(systemName: "rectangle.and.hand.point.up.left.fill")
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundColor(.teal)
                                    .font(.body.bold())
                                
                                Text("Decipher the Message")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.teal)
                                    .offset(y: -1)
                            }
                            Text("Use the wheel to shift each letter in the message, until it makes sense.")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(.quaternary, lineWidth: 1)
                        }
                        Spacer()
                    }
                    .padding(.top, 12)
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(.mint.opacity(0.2), lineWidth: 1)
                    .overlay {
                        VStack {
                            Text(shifted)
                                .font(.title3.monospaced())
                                .fontWeight(.medium)
                                .padding()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(.quaternary.opacity(0.5), lineWidth: 2)
                                }
                                .padding()
                            
                            Spacer()
                            
                            Caesar(shift: $shift)
                            
                            Spacer()
                        }
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
                .disabled(shifted != target)
                .buttonStyle(.borderedProminent)
                .tint(.teal)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct CaesarPage_Previews: PreviewProvider {
    static var previews: some View {
        CaesarPage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
        
    }
}
