//
//  DrageGestureBootcamp.swift
//  SwiftUIListThree
//
//  Created by Fadel Sultan on 16/10/1444 AH.
//

import SwiftUI

struct DrageGestureBootcamp: View {
    
    @State private var offset:CGSize = .zero
    
    
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("\(offset.width)")
                Spacer()
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300,height: 500)
                .offset(offset)
                .scaleEffect(getScalAmount())
                .rotationEffect(Angle(degrees: getRotationAount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                offset = value.translation
                                
                                
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                offset = .zero
                                
                            }
                        }
                )
            
            
        }
    }
    
    private func getScalAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    private func getRotationAount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle:Double = 10
        return percentageAsDouble * maxAngle
    }
}

struct DrageGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DrageGestureBootcamp()
    }
}
