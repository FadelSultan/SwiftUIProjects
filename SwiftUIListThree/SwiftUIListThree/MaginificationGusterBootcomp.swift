//
//  MaginificationGusterBootcomp.swift
//  SwiftUIListThree
//
//  Created by Fadel Sultan on 15/10/1444 AH.
//

import SwiftUI

struct MaginificationGusterBootcomp: View {
    
    @State private var currentAmount:CGFloat = 0
    @State private var lastAmount:CGFloat = 0
    
    var body: some View {
        
        
        VStack(spacing:10) {
            HStack {
                Circle()
                    .frame(width: 50 , height: 50)
                Text("Fadel Sultan")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "ellipsis")
            }.padding(.horizontal)
            
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }.padding(.horizontal).font(.title)
        }
        
        
//Example1
//        Text("Hello, World!")
//            .font(.title2)
//            .padding()
//            .background(Color.red)
//            .cornerRadius(10)
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        currentAmount = value - 1
//                    }
//                    .onEnded { value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
    }
}

struct MaginificationGusterBootcomp_Previews: PreviewProvider {
    static var previews: some View {
        MaginificationGusterBootcomp()
    }
}
