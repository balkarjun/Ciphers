import SwiftUI

struct ContentView: View {
    @StateObject var state = AppState()
    
    var body: some View {
        Group {
            switch state.page {
            case .zero:
                WelcomePage()
            case .one:
                PigpenPage()
            case .two:
                CaesarPage()
            case .three:
                EmptyView()
            case .four:
                EmptyView()
            }
        }
        .environmentObject(state)
    }
}
