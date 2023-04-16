//
//  CaesarPage.swift
//  Ciphers
//
//  Created by Arjun B on 13/04/23.
//

import SwiftUI

struct CaesarPage: View {
    let encrypted = cshift(message: "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased(), by: 10)
    
    let target = "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased()
    
    @State private var shift: Int = 0
    
    private var shifted: String {
        cshift(message: encrypted, by: shift)
    }
    
    var body: some View {
        SplitView(page: .two, disabled: shifted != target) {
            VStack(alignment: .leading) {
                Text(encrypted)
                    .font(.title3.monospaced())
                    .fontWeight(.medium)
                    .padding()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                
                InteractionPrompt(
                    symbol: "rectangle.and.hand.point.up.left.fill",
                    title: "Decipher the Message",
                    description: "Turn the wheel in the interactive area to shift each letter in the message, until it becomes readable."
                )
                
                Text("We've replaced the pigpen symbols with their matching letters, but the message still doesn't make sense.\n\nThat's because this message is encoded using a ***Caesar Cipher***, where each letter is replaced by another letter some fixed number of positions down the alphabet. Here's an example:")
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
                
                Text("To decode the message, we simply shift it back by the same number of positions.")
                    .padding()
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
                    .animation(.none, value: shifted)
                
                Spacer()
                
                CaesarWheel(shift: $shift)
                Spacer()
                
                HStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.body.bold())
                    
                    Text("Use two fingers to rotate the inner wheel, or use the arrows.")
                        .font(.callout.monospaced())
                }
                .padding()
                .foregroundColor(.secondary)
            }
        }
    }
}

struct CaesarPage_Previews: PreviewProvider {
    static var previews: some View {
        CaesarPage()
            .previewInterfaceOrientation(.landscapeLeft)            .environmentObject(AppState())
    }
}
