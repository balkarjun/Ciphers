import SwiftUI

enum AppPage: Int, CaseIterable {
    case welcome = 0
    case pigpenInfo = 1
    case pigpenCipher = 2
    case caesarInfo = 3
    case caesarCipher = 4
    case grilleInfo = 5
    case grilleCipher = 6
    case final = 7
}

struct ContentView: View {
    @State private var currentPage: AppPage = .welcome
    private var isFirstPage: Bool {
        currentPage.rawValue <= 0
    }
    
    private var isLastPage: Bool {
        currentPage.rawValue >= AppPage.allCases.count - 1
    }
    
    func nextPage() {
        if isLastPage { return }
        
        currentPage = AppPage(rawValue: currentPage.rawValue + 1) ?? .welcome
    }
    
    func prevPage() {
        if isFirstPage { return }
        
        currentPage = AppPage(rawValue: currentPage.rawValue - 1) ?? .welcome
    }
    
    private var pageTitle: String {
        switch currentPage {
        case .welcome:
            return "Welcome"
        case .pigpenInfo:
            return "Pigpen Info"
        case .pigpenCipher:
            return "Pigpen Cipher"
        case .caesarInfo:
            return "Caesar Info"
        case .caesarCipher:
            return "Caesar Cipher"
        case .grilleInfo:
            return "Grille Info"
        case .grilleCipher:
            return "Grille Cipher"
        case .final:
            return "Final"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: prevPage) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Previous")
                    }
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .disabled(isFirstPage)
                
                Text(pageTitle)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(.quaternary.opacity(0.5))
                    .cornerRadius(6)
                
                Button(action: nextPage) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .disabled(isLastPage)
            }
            .padding(.horizontal)
            
            ScrollView {
                switch currentPage {
                case .welcome:
                    WelcomeView()
                case .pigpenInfo:
                    PigpenInfoView()
                case .caesarInfo:
                    EmptyView()
                case .caesarCipher:
                    CaesarCipher()
                case .pigpenCipher:
                    PigpenSection()
                case .grilleInfo:
                    EmptyView()
                case .grilleCipher:
                    GrilleCipher()
                case .final:
                    EmptyView()
                }
            }
        }
    }
}
