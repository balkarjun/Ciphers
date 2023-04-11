//
//  WelcomeView.swift
//  Ciphers
//
//  Created by Arjun B on 11/04/23.
//

import SwiftUI

struct WelcomeView: View {
    let target = "Viewed through holes of light, hidden in plain sight, the clue faces left from right".uppercased()

    var body: some View {
        VStack(alignment: .leading) {
            Text("A cipher is a secret code, a way to encode a message so that only the intended recipient can read the message.")
            
            PigpenText(target, highlighted: "", completed: [])
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(.quaternary, lineWidth: 1)
                }
            
            Text("You've been given the above cipher, which contains the key to unlocking a hidden treasure. Through this series of interactive tutorials, you will learn about some of various ciphers used throughout history, and solve this cipher one step at a time.")
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
