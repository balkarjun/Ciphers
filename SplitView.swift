//
//  SplitView.swift
//  Ciphers
//
//  Created by Arjun B on 15/04/23.
//

import SwiftUI

struct SplitView<LeadingView: View, TrailingView: View>: View {
    let page: AppPage
    let disabled: Bool
    let action: () -> Void
    var leading: () -> LeadingView
    var trailing: () -> TrailingView
    
    @State private var aboutSheetShown: Bool = false
    
    private var actionName: String {
        if page == .four {
            return "Play Again"
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
    
    private var pageSymbol: String {
        switch page {
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
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: pageSymbol)
                        .font(.body.weight(.bold))
                        .foregroundColor(.teal)
                    
                    Text(pageName)
                        .font(.body.weight(.semibold))
                    
                    Spacer()
                    Button {
                        aboutSheetShown = true
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.body.weight(.medium))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.mint.opacity(0.15))
                .cornerRadius(8)
                
                ScrollView {
                    leading()
                        .padding(.top, 12)
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(.mint.opacity(0.2), lineWidth: 1)
                    
                    trailing()
                        .padding()
                }
                
                Button(action: action) {
                    HStack {
                        Text(actionName)
                            .font(.body.bold())
                        Spacer()
                        Image(systemName: actionSymbol)
                            .font(.body.bold())
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                }
                .disabled(disabled)
                .buttonStyle(.borderedProminent)
                .tint(.teal)
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
            
        } leading: {
            Text("Left")
        } trailing: {
            VStack {
                Text("Right")
            }
        }
    }
}

struct TestView: View {
    var body: some View {
        VStack {
            Text("Right")
        }
    }
}
