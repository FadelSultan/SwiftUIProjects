//
//  DrageGestureBootcamp2.swift
//  SwiftUIListThree
//
//  Created by Fadel Sultan on 16/10/1444 AH.
//

import SwiftUI

struct DrageGestureBootcamp2: View {
    
    
    
    @State private var startingOffsetY:CGFloat = UIScreen.main.bounds.height * 0.82
    @State private var currentDragOffsetY:CGFloat = 0
    @State var endingOffsetY:CGFloat = 0
    
    
    var body: some View {

        ZStack {
            Color.purple
                .ignoresSafeArea()
            
            MySignUpView(endingOffsetY: $endingOffsetY)
                .offset(y:startingOffsetY)
                .offset(y:currentDragOffsetY)
                .offset(y:endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged{value in
                            withAnimation(.spring()){
                                
//                                I added this condition to stop view goes up when signup view is open
                                
                                if endingOffsetY != 0 && value.translation.height > 0 {
                                    currentDragOffsetY = value.translation.height
                                }else if endingOffsetY == 0 {
                                    currentDragOffsetY = value.translation.height
                                }
                            }
                        }
                        .onEnded{value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                }else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                
                                currentDragOffsetY = 0
                            }
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DrageGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        DrageGestureBootcamp2()
    }
}

struct  MySignUpView: View {
    
    @Binding var endingOffsetY:CGFloat
    
    var body: some View {
        VStack {
            Image(systemName: endingOffsetY == 0 ? "chevron.up" : "chevron.down")
                .padding(.top)
                .padding(.bottom,8)
                .font(.headline)
                .fontWeight(.heavy)
            
            Text("Sing Up")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom,30)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100 , height: 100)
            
            Text("This is the description for our app. This is my favorite swiftui course and I recomment to all of my friends to subscrip to swiftful Thanks!")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            Text("Create an account".uppercased())
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black)
                .cornerRadius(10)
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(30)
        .padding(.top)
    }
}
