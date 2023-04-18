//
//  SplitView.swift
//  Ciphers
//
//  Created by Arjun B on 15/04/23.
//

import SwiftUI

struct SplitView<LeadingView: View, TrailingView: View>: View {
    @EnvironmentObject var state: AppState
    
    let page: AppPage
    let disabled: Bool
    var leading: () -> LeadingView
    var trailing: () -> TrailingView
    
    @State private var aboutSheetShown: Bool = false
    
    @State private var answer: String = ""
    
    private var actionName: String {
        if page == .four {
            return "Play Again"
        } else if page == .zero {
            return "Start"
        }
        
        return "Next"
    }
    
    private var actionSymbol: String {
        if page == .four {
            return "arrow.clockwise"
        }
        
        return "arrow.right"
    }
    
    private var pageName: String {
        switch page {
        case .zero:
            return "Introduction"
        case .one:
            return "Pigpen Cipher"
        case .two:
            return "Caesar Cipher"
        case .three:
            return "Grille Cipher"
        case .four:
            return "Congratulations"
        }
    }
    
    private var pageNumber: Int {
        page.rawValue + 1
    }
    
    private func action() {
        if page == .four {
            state.reset()
        } else {
            state.nextPage()
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(pageNumber, format: .number)
                            .font(.body.weight(.bold).monospacedDigit())
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal, 2)
                        
                        Rectangle()
                            .fill(Color.accentColor.opacity(0.2))
                            .frame(width: 2)
                            .padding(.horizontal)
                        
                        Text(pageName)
                            .font(.body.weight(.semibold))
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Section \(pageNumber), \(pageName)")
                    
                    Spacer()
                    
                    Menu {
                        Button(action: state.reset) {
                            Label("Restart", systemImage: "arrow.clockwise")
                        }
                        
                        Button {
                            aboutSheetShown = true
                        } label: {
                            Label("About Ciphers", systemImage: "info.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title3.weight(.semibold))
                            .symbolRenderingMode(.hierarchical)
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.accentColor.opacity(0.15))
                .cornerRadius(8)
                .accessibilityAddTraits(.isHeader)
                
                ScrollView(showsIndicators: false) {
                    leading()
                        .padding(.top, 12)
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(Color.accentColor.opacity(0.2), lineWidth: 1)
                    
                    trailing()
                        .padding()
                }
                
                if page != .three {
                    Button(action: action) {
                        HStack {
                            Text(actionName)
                            
                            Spacer()
                            
                            Image(systemName: actionSymbol)
                        }
                        .padding(8)
                        .font(.body.bold())
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(disabled)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.accentColor)
                    .accessibilityAddTraits(.isHeader)
                } else {
                    HStack {
                        TextField("Enter the key here...", text: $answer)
                            .textInputAutocapitalization(.characters)
                            .disableAutocorrection(true)
                            .font(.body.monospaced())
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(.thinMaterial, lineWidth: 1)
                            }
                        
                        Button(action: state.nextPage) {
                            HStack {
                                Text("Finish")
                                
                                Image(systemName: actionSymbol)
                            }
                            .font(.body.bold())
                            .padding(8)
                        }
                        .disabled(answer.uppercased() != state.solution)
                        .buttonStyle(.borderedProminent)
                        .tint(Color.accentColor)
                    }
                    .accessibilityAddTraits(.isHeader)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .sheet(isPresented: $aboutSheetShown) {
            AppInfo()
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(page: .zero, disabled: false) {
            Text("Left")
        } trailing: {
            VStack {
                Text("Right")
            }
        }
        .environmentObject(AppState())
    }
}
