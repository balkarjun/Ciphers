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
            VStack {
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
                
                Text(encrypted)
                    .font(.title2.monospaced())
                    .fontWeight(.medium)
                    .padding()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(.mint.opacity(0.2), lineWidth: 1)
                    .overlay {
                        VStack {
                            Text(shifted)
                                .font(.title2.monospaced())
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
