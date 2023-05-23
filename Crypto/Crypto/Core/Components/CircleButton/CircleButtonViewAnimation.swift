//
//  CircleButtonViewAnimation.swift
//  Crypto
//
//  Created by Fadel Sultan on 03/11/1444 AH.
//

import SwiftUI

struct CircleButtonViewAnimation: View {
    
    @Binding var isAnimat:Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(isAnimat ? 1.0 : 0.0)
            .opacity(isAnimat ? 0 : 1.0)
            .animation(isAnimat ? Animation.easeInOut(duration: 1.0) : nil , value: 0)
    }
}

struct CircleButtonViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonViewAnimation(isAnimat: .constant(false))
            .foregroundColor(.red)
            .frame(width: 100 , height: 100)
    }
}
