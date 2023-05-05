//
//  RotationGestureBootcamp.swift
//  SwiftUIListThree
//
//  Created by Fadel Sultan on 16/10/1444 AH.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State private var angle:Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(Color.blue.opacity(0.7))
            .cornerRadius(10)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { value in
                        angle = Angle(degrees: 0)
                    }
            )
    }
}

struct RotationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureBootcamp()
    }
}
