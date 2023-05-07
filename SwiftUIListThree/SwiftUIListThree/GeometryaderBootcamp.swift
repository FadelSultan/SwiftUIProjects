//
//  GeometryaderBootcamp.swift
//  SwiftUIListThree
//
//  Created by Fadel Sultan on 17/10/1444 AH.
//

import SwiftUI

struct GeometryaderBootcamp: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 40), axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300 , height: 200)
                    .padding()
                    
                }
            }
        }
    }
    
    func getPercentage(geo:GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return 1.0 - (currentX / maxDistance)
    }
}

struct GeometryaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryaderBootcamp()
    }
}
