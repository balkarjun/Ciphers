//
//  CaesarPage.swift
//  Ciphers
//
//  Created by Arjun B on 13/04/23.
//

import SwiftUI

struct CaesarPage: View {
    @EnvironmentObject var state: AppState
    
    let encrypted = cshift(message: "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased(), by: 10)
    
    let target = "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased()
    
    @State private var shift: Int = 0
    
    private var shifted: String {
        cshift(message: encrypted, by: shift)
    }
    
    var body: some View {
        SplitView(page: .two, disabled: shifted != target) {
            state.nextPage()
        } leading: {
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
                        Text(cshift(message: "APPLE", by: 1))
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
            }
        } trailing: {
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
    }
}

struct CaesarPage_Previews: PreviewProvider {
    static var previews: some View {
        CaesarPage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
        
    }
}
