//
//  HomeView.swift
//  Crypto
//
//  Created by Fadel on 03/11/1444 AH.
//

import SwiftUI

struct HomeView: View {
    @State private var showportfolio:Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                
                HomeHeader
                Spacer(minLength: 0)
            }//:VSTACK
        }//:ZSTACK
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}


extension HomeView {
    private var HomeHeader:some View {
        HStack {
            CircleButtonView(iconName: showportfolio ? "plus" : "info")
                .background(
                    CircleButtonViewAnimation(isAnimat: $showportfolio)
                    
                )
            Spacer()
            
            Text(showportfolio ? "Protfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showportfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showportfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
