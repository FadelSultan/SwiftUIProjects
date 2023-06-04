//
//  HomeView.swift
//  Crypto
//
//  Created by Fadel on 03/11/1444 AH.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm:HomeViewModel
    @State private var showPortfolio:Bool = false //animate right
    @State private var showPortfolioShow:Bool = false // new sheet
    
    var body: some View {
        ZStack {
            
            
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioShow) {
                    PortfolioView(isPresented: $showPortfolioShow)
                        .environmentObject(vm)
                }
            
            VStack {
                
                HomeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
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
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonViewAnimation(isAnimat: $showPortfolio))
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioShow.toggle()
                    }
                }
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList:some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, isShowHoldingsColumn: false)
            }
        }
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        .listStyle(PlainListStyle())
        
    }
    
    private var portfolioCoinsList:some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, isShowHoldingsColumn: true)
            }
        }
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles:some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
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
