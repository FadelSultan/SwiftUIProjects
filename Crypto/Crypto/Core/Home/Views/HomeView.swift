//
//  HomeView.swift
//  Crypto
//
//  Created by Fadel on 03/11/1444 AH.
//

import SwiftUI

struct HomeView: View {
    
    
    @EnvironmentObject private var vm:HomeViewModel
    
    @State private var showportfolio:Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                
                HomeHeader
                
                columnTitles
                
                if !showportfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                    
                }
                
                if showportfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                        
                }
                
                
                
                
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
        .environmentObject(dev.homeVM )
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
    
    private var allCoinsList:some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, isShoweHoldingsColumn: false)
            }
        }
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        .listStyle(PlainListStyle())
        
    }
    
    private var portfolioCoinsList:some View {
        List {
            ForEach(vm.protfolioCoins) { coin in
                CoinRowView(coin: coin, isShoweHoldingsColumn: true)
            }
        }
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles:some View {
        HStack {
            Text("Coin")
            Spacer()
            if showportfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }

}
