//
//  InteractionPrompt.swift
//  Ciphers
//
//  Created by Arjun B on 15/04/23.
//

import SwiftUI

struct InteractionPrompt: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.teal)
                
                Rectangle()
                    .fill(Color.accentColor.opacity(0.25))
                    .frame(height: 1)
            }

            HStack {
                Image(systemName: "rectangle.and.hand.point.up.left.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.teal)
                    .font(.body.bold())

                Text(description)
            }
            
            Rectangle()
                .fill(Color.accentColor.opacity(0.25))
                .frame(height: 1)
                .padding(.top, 8)
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

struct InteractionPrompt_Previews: PreviewProvider {
    static var previews: some View {
        InteractionPrompt(title: "Decipher the Message", description: "Use the wheel in the interactive area to shift each letter in the message, until it makes sense.")
            .padding(100)
    }
}
