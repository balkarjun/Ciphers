//
//  AppInfo.swift
//  Ciphers
//
//  Created by Arjun B on 15/04/23.
//

import SwiftUI

struct AppInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Ciphers")
                .font(.title.bold())
            
            Text("Decode the cryptic message to find the secret keyword, \nand learn about some ciphers along the way.")

            Divider()
                .padding(.vertical)
            
            Text("Thank you for checking out this little app that I put a lot of effort into.\nCiphers was built over the course of 2 weeks as my submission to the WWDC23 Swift Student Challenge.")
                .font(.body)
            
            HStack {
                Link(destination: URL(string: "https://github.com/balkarjun")!) {
                    Image(systemName: "link")
                        .font(.body.bold())
                        .padding(12)
                        .background(Color.accentColor.opacity(0.1))
                        .cornerRadius(8)
                }
                
                VStack(alignment: .leading) {
                    Text("Arjun Balakrishnan")
                        .font(.body.bold())
                    Text("Designer & Developer")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .padding()
    }
}

struct AppInfo_Previews: PreviewProvider {
    static var previews: some View {
        AppInfo()
    }
}
