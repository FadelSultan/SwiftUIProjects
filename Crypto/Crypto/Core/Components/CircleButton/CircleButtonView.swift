//
//  CircleButtonView.swift
//  Crypto
//
//  Created by Fadel on 03/11/1444 AH.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName:String
    
    var body: some View {
        ZStack {
            
            Image(systemName: iconName)
                .font(.headline)
                .foregroundColor(.theme.accent)
                .frame(width: 50 , height: 50)
                .background(
                    Circle()
                        .foregroundColor(.theme.background)
                )
                .shadow(color: .theme.accent.opacity(0.25),radius: 10)
                .padding()
            
        }
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CircleButtonView(iconName: "heart.fill")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
            
        }
    }
}
