import SwiftUI

enum AppPage: Int, CaseIterable {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
}

struct ContentView: View {
    @State private var currentPage: AppPage = .one
    private var isFirstPage: Bool {
        currentPage.rawValue <= 0
    }
    
    private var isLastPage: Bool {
        currentPage.rawValue >= AppPage.allCases.count - 1
    }
    
    func nextPage() {
        if isLastPage { return }
        
        currentPage = AppPage(rawValue: currentPage.rawValue + 1) ?? .zero
    }
    
    func prevPage() {
        if isFirstPage { return }
        
        currentPage = AppPage(rawValue: currentPage.rawValue - 1) ?? .zero
    }
    
    var body: some View {
        VStack {
            /*
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
            */
            
            switch currentPage {
            case .zero:
                WelcomePage()
            case .one:
                PigpenPage()
            case .two:
                EmptyView()
            case .three:
                EmptyView()
            case .four:
                EmptyView()
            }
            /*
            switch currentPage {
            case .welcome:
                WelcomePage()
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
            */
        }
    }
}
