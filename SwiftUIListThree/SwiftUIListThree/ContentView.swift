//
//  ContentView.swift
//  SwiftUIListThree
//
//  Created by Fadel Sultan on 15/10/1444 AH.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isComplate:Bool = false
    @State private var isSuccess:Bool = false
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplate ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity , alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Start")
                    .padding()
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50,pressing: { isPressing in
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplate = true
                            }
                        }else {
                            withAnimation(.easeInOut) {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if !isSuccess {
                                        withAnimation(.easeInOut) {
                                            isComplate = false
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }) {
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                
                Text("Reset")
                    .padding()
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture {
                        isComplate = false
                        isSuccess = false
                    }
                
            }
        }
        
        
        
        //Example 1
        /*
         VStack {
         Image(systemName: "globe")
         .imageScale(isComplate ? .large : .small)
         .foregroundColor(isComplate ? .accentColor : .orange)
         .padding(.bottom , 10)
         Text(isComplate ?  "Is Complated" : "Not complate")
         }
         .padding()
         .padding(.horizontal)
         .background(isComplate ?  Color.gray : Color.gray.opacity(0.5))
         .cornerRadius(10)
         .offset(y: isComplate ? 10 : 0)
         .onLongPressGesture {
         withAnimation(.linear) {
         isComplate.toggle()
         }
         }
         */
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
