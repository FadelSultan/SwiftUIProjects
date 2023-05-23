//
//  ContentView.swift
//  Crypto
//
//  Created by Fadel on 03/11/1444 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing:20) {
                Text("Green")
                    .foregroundColor(Color.theme.green)
                
                Text("Red")
                    .foregroundColor(Color.theme.red)
                
                Text("Secondary")
                    .foregroundColor(Color.theme.secondaryText)
                
                Text("Accent")
                    .foregroundColor(Color.theme.accent)
                
                
            }.font(.headline)
        }//:ZSTACK
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
