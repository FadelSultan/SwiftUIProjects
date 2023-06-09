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
    @State private var isShowSettingsView:Bool = false // new sheet
    @State private var selectedCoin:CoinModel? = nil
    @State private var isShowDetailView:Bool = false
    
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
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            portfolioEmptyText
                        }else {
                            portfolioCoinsList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }.sheet(isPresented: $isShowSettingsView) {
                SettingsView(isCloseView: $isShowSettingsView)
            }//:VSTACK
        }//:ZSTACK
        .navigationDestination(
            isPresented: $isShowDetailView,
            destination: {
            DetailLoadingView(coin: $selectedCoin)
        })
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
                    }else {
                        isShowSettingsView.toggle()
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
                CoinRowView(coin: coin, isShowHoldingsColumn: false).listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        
        .listStyle(PlainListStyle())
        
    }
    
    private var portfolioCoinsList:some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, isShowHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                
            }
        }

        .listStyle(PlainListStyle())
    }
    
    private var portfolioEmptyText:some View {
        Text("You haven't added any coins to your portfolio yet. Click the + button to get started! 🧐")
            .font(.callout)
            .foregroundColor(Color.theme.secondaryText)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private var columnTitles:some View {
        HStack {
            HStack(spacing:4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            
            Spacer()
            if showPortfolio {
                
                HStack(spacing:4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOption == .holdings || vm.sortOption == .holdingsReversed ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
                
            }
            
            HStack(spacing:4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0) , anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private func segue(coin:CoinModel) {
        selectedCoin = coin
        isShowDetailView.toggle()
    }
}
