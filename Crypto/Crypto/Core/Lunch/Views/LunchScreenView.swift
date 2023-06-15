//
//  LunchScreenView.swift
//  Crypto
//
//  Created by Fadel on 26/11/1444 AH.
//

import SwiftUI

struct LunchScreenView: View {
    
    @State private var loadingText:[String] = "Loading your portfolio...".map({String($0)})
    @State private var showLoadingText:Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var loops:Int = 0
    @State private var counter:Int = 0
    @Binding var showLunchView:Bool
    
    var body: some View {
        ZStack {
            Color.lunch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100,height: 100)
            
            ZStack {
                if showLoadingText {
                    HStack(spacing:0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.lunch.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }.transition(AnyTransition.scale.animation(.easeIn))
                }
            }.offset(y:70)
                
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops > 1 {
                        showLunchView = false
                    }
                }else {
                    counter += 1
                }
            }
        }
    }
}

struct LunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LunchScreenView(showLunchView: .constant(true))
    }
}
