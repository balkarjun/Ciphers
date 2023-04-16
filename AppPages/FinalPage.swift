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
    
    @State private var screenWidth: Double = 0
    @State private var stage: ProgressStage = .four
    
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
            return state.solution
        }
    }
    
    private var isPigpen: Bool {
        stage == .zero
    }
    
    private var primaryColor: Color {
        (colorScheme == .dark) ? .white : .black
    }
    
    var body: some View {
        SplitView(page: .four, disabled: false) {
            VStack(alignment: .leading) {
                Text("**Congratulations!**\nUsing Pigpen, Caesar and Grille Ciphers, you decoded the message and found the secret key. Hope you had fun learning about these ciphers along the way.\n\nYou can view the results of each stage using the buttons to the right, or play again from the beginnning.")
                    .padding()
                
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
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay {
                    Color.clear.measureSize { screenWidth = $0.width }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(8)
            }
        } trailing: {
            VStack {
                StageButton(stage: .zero, activeStage: $stage)

                StageButton(stage: .one, activeStage: $stage)

                StageButton(stage: .two, activeStage: $stage)
                
                StageButton(stage: .three, activeStage: $stage)
                
                StageButton(stage: .four, activeStage: $stage)
                
                Spacer()
            }
        }
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
                    .foregroundColor(isActive ? .teal : .secondary)
                    .symbolRenderingMode(.hierarchical)
                    .font(.title3.weight(.bold))

                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.body.weight(.semibold))
                    .foregroundColor(.primary)
            }
            .padding()
            .background(isActive ? .teal.opacity(0.15) : .clear)
            .cornerRadius(8)
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
