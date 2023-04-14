//
//  FinalPage.swift
//  Ciphers
//
//  Created by Arjun B on 14/04/23.
//

import SwiftUI

enum ProgressStage {
    case zero, one, two, three, four
}

struct FinalPage: View {
    @EnvironmentObject var state: AppState
    
    let encrypted = cshift(message: "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased(), by: 10)
    
    let decrypted = "Viewed through holes of light,\nhidden in plain sight, the clue\nfaces left from right".uppercased()
    
    let blocked = "...... ......h ....s o. ....t.\n.....n .. ...i. ...... ... c...\n.a... .... ...m ....".uppercased()

    let solution = "MACINTOSH"
    
    private let charWidth: Double = 18
    private let charHeight: Double = 18
    // space between two consecutive characters
    private let kerning: Double = 6
    // space between rows of characters
    private let lineSpacing: Double = 6
    @State private var screenWidth: Double = 0
    
    // number of characters that can fit in a line
    private var lineLength: Int {
        if screenWidth == 0 { return 1 }

        return Int(screenWidth / (charWidth + kerning))
    }
    
    @State private var stage: ProgressStage = .zero
    
    private var text: String {
        switch stage {
        case .zero:
            return encrypted
        case .one:
            return encrypted
        case .two:
            return decrypted
        case .three:
            return blocked
        case .four:
            return solution
        }
    }
    
    private var isPigpen: Bool {
        stage == .zero
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "4.circle.fill")
                        .font(.body.weight(.bold))
                        .foregroundColor(.teal)
                    
                    Text("Congratulations")
                        .font(.body.weight(.semibold))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.mint.opacity(0.15))
                .cornerRadius(8)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ChunkedText(
                            text: text,
                            chunkSize: lineLength,
                            pigpen: isPigpen
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay {
                            Color.clear.measureSize { screenWidth = $0.width }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                        
                        Text("You've solved the puzzle! Using Pigpen, Caesar and Grille Ciphers, you uncovered the hidden message and found the secret key.")
                            .padding()
                        
                        Text("You can view the results of each stage using the buttons to the right, or play again from the beginnning.")
                            .padding(.horizontal)
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
                            StageButton(stage: .zero, activeStage: $stage)

                            StageButton(stage: .one, activeStage: $stage)

                            StageButton(stage: .two, activeStage: $stage)
                            
                            StageButton(stage: .three, activeStage: $stage)
                            
                            StageButton(stage: .four, activeStage: $stage)
                            
                            Spacer()
                        }
                        .padding()
                    }
                
                Button {
                    state.page = .zero
                } label: {
                    HStack {
                        Text("Play Again")
                            .font(.body.bold())
                        Spacer()
                        Image(systemName: "arrow.clockwise")
                            .font(.body.bold())
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.teal)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct StageButton: View {
    let stage: ProgressStage
    
    @Binding var activeStage: ProgressStage
    
    private var isActive: Bool {
        stage == activeStage
    }
    
    private var symbol: String {
        switch stage {
        case .zero:
            return "0.circle.fill"
        case .one:
            return "1.circle.fill"
        case .two:
            return "2.circle.fill"
        case .three:
            return "3.circle.fill"
        case .four:
            return "4.circle.fill"
        }
    }
    
    private var description: String {
        switch stage {
        case .zero:
            return "Original Message"
        case .one:
            return "Deciphered using Pigpen"
        case .two:
            return "Deciphered using Caesar Shift"
        case .three:
            return "Deciphered using Grille"
        case .four:
            return "Secret Key"
        }
    }
    
    var body: some View {
        Button {
            activeStage = stage
        } label: {
            HStack {
                Image(systemName: symbol)
                    .font(.title3.weight(.bold))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.secondary)

                Text(description)
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
            }
            .padding()
            .background(.thinMaterial)
            .background(isActive ? .mint.opacity(0.15) : .clear)
            .cornerRadius(8)
        }
    }
}

struct FinalPage_Previews: PreviewProvider {
    static var previews: some View {
        FinalPage()
            .environmentObject(AppState())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
