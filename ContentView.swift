import SwiftUI

struct ContentView: View {
    @StateObject var state = AppState()
    // best viewed in landscape orientation
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
                GrillePage()
            case .four:
                FinalPage()
            }
        }
        .environmentObject(state)
    }
}
