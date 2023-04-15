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
                .font(.title2.bold())
            Text("Thank you for checking out this silly little app that I put a lot of effort into.\nCiphers was built in 2 weeks as my submission to the WWDC23 Swift Student Challenge.")
                .multilineTextAlignment(.leading)
                .font(.body)
            
            VStack(alignment: .leading) {
                Text("Arjun Balakrishnan")
                    .font(.body.bold())
                Text("Designer & Developer")
                    .foregroundColor(.secondary)
            }
            .padding(.top)
            
            Divider()
                .padding(.vertical)
            
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
