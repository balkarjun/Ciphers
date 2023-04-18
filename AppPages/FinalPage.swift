//
//  FinalPage.swift
//  Ciphers
//
//  Created by Arjun B on 14/04/23.
//

import SwiftUI

struct FinalPage: View {
    @EnvironmentObject var state: AppState
    
    @State private var stage: AppPage = .four
    @State private var screenWidth: Double = 0
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var text: String {
        switch stage {
        case .zero:
            return state.encrypted
        case .one:
            return state.encrypted
        case .two:
            return state.decrypted
        case .three:
            return state.blocked
        case .four:
            let result = "...... ....... ..... .. ......\n.. MACINTOSH .. ...... ... ....\n..... .... .... ....."

            return result
        }
    }
    
    var isFirstStage: Bool {
        stage.rawValue <= 0
    }
    
    var isLastStage: Bool {
        stage.rawValue >= AppPage.allCases.count - 1
    }
    
    func nextStage() {
        if isLastStage { return }
        
        stage = AppPage(rawValue: stage.rawValue + 1) ?? .four
    }
    
    func prevStage() {
        if isFirstStage { return }
        
        stage = AppPage(rawValue: stage.rawValue - 1) ?? .four
    }
    
    private var isPigpen: Bool {
        stage == .zero
    }
    
    private var primaryColor: Color {
        (colorScheme == .dark) ? .white : .black
    }
    
    private var description: String {
        switch stage {
        case .zero:
            return "Original Message"
        case .one:
            return "After Pigpen Cipher"
        case .two:
            return "After Caesar Cipher"
        case .three:
            return "After Grille Cipher"
        case .four:
            return "Keyword"
        }
    }
    
    var body: some View {
        SplitView(page: .four, disabled: false) {
            VStack(alignment: .leading) {
                Text("Congratulations!")
                    .font(.body.bold())
                    .padding(.horizontal)
                
                Text("Using Pigpen, Caesar and Grille Ciphers, you deciphered the message and found the keyword.\nHope you had fun solving these ciphers along the way.")
                    .padding(.horizontal)
                
                Text("You can view the results of each stage, or play again from the beginnning.")
                    .foregroundColor(.secondary)
                    .padding(.top)
                    .padding(.horizontal)
            }
        } trailing: {
            VStack {
                ChunkedText(
                    text: text,
                    limit: screenWidth
                ) { char in
                    Group {
                        if isPigpen {
                            PigpenCharacter(char, lineColor: primaryColor)
                        } else {
                            Text(char)
                                .font(.title3.monospaced().weight(.semibold))
                                .foregroundColor(char == "." ? .secondary.opacity(0.5) : .primary)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay {
                    Color.clear.measureSize { screenWidth = $0.width }
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(8)
                
                HStack {
                    Button(action: prevStage) {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.title2.bold())
                            .symbolRenderingMode(.hierarchical)
                    }
                    .disabled(isFirstStage)
                    
                    Text(description)
                        .font(.callout.bold().monospaced())
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                    
                    Button(action: nextStage) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.title2.bold())
                            .symbolRenderingMode(.hierarchical)
                    }
                    .disabled(isLastStage)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.thinMaterial)
                .cornerRadius(8)
                
                Spacer()
            }
        }
    }
}

struct FinalPage_Previews: PreviewProvider {
    static var previews: some View {
        FinalPage()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(AppState())
    }
}
