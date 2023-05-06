//
//  DrageGestureBootcamp2.swift
//  SwiftUIListThree
//
//  Created by Fadel Sultan on 16/10/1444 AH.
//

import SwiftUI

struct DrageGestureBootcamp2: View {
    var body: some View {
        
        
        ZStack {
            Color.purple
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "chevron.up")
                    .padding(.top)
                Text("Sing Up")
                    .font(.headline)
                    .fontWeight(.semibold)
                
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
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DrageGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        DrageGestureBootcamp2()
    }
}
