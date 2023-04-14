//
//  GrillePage.swift
//  Ciphers
//
//  Created by Arjun B on 13/04/23.
//

import SwiftUI

struct GrillePage: View {
    @EnvironmentObject var state: AppState
    @State private var answer: String = ""

    let target = "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased()

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "3.circle.fill")
                        .font(.body.weight(.bold))
                        .foregroundColor(.teal)
                    
                    Text("Grille Cipher")
                        .font(.body.weight(.semibold))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.mint.opacity(0.15))
                .cornerRadius(8)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(target)
                            .font(.title3.monospaced())
                            .fontWeight(.medium)
                            .padding()
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.ultraThinMaterial)
                            .cornerRadius(8)
                        
                        Text("In a ***Grille Cipher***, the message is hidden in plain sight, and is visible when viewed through a stencil or piece of paper with holes in it.")
                            .padding([.horizontal, .top])
                        
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Image(systemName: "rectangle.and.hand.point.up.left.fill")
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundColor(.teal)
                                    .font(.body.bold())
                                
                                Text("Find the Hidden Key")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.teal)
                                    .offset(y: -1)
                            }
                            Text("Align the stencil with the text to uncover the secret key.")
                            
                            Text("***Hint***: Make sure you read the message. It holds the clue as to how to decode the message.")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(.quaternary, lineWidth: 1)
                        }
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
                            Grille()
                                .padding()
                                .padding()
                            Spacer()
                            
                            TextField("Enter the key here...", text: $answer)
                                .font(.body.monospaced())
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.characters)
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(.quaternary, lineWidth: 1)
                                }
                                .padding([.horizontal, .bottom])
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
                .disabled(answer.uppercased() != "MACINTOSH")
                .buttonStyle(.borderedProminent)
                .tint(.teal)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct GrillePage_Previews: PreviewProvider {
    static var previews: some View {
        GrillePage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
    }
}
