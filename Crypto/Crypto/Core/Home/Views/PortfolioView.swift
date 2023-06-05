//
//  PortfolioView.swift
//  Crypto
//
//  Created by Fadel on 15/11/1444 AH.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm:HomeViewModel
    @Binding var isPresented:Bool
    @State private var selectedCoin:CoinModel? = nil
    @State private var quantityText:String = ""
    @State private var showCheckMark:Bool = false
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(alignment: .leading , spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            
            
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(isPresented: $isPresented)
                }
                
                ToolbarItem(placement:.navigationBarTrailing) {
                    trailingNavBarButtons
                }
            }.onChange(of: vm.searchText) { newValue in
                if newValue == "" && selectedCoin == nil {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(isPresented: .constant(false))
            .environmentObject(dev.homeVM)
    }
}


extension PortfolioView {
    private var coinLogoList:some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHStack(spacing:10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins :  vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .fill(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear)
                        )
                }
                
            }
            .padding(.horizontal,4)
            .padding(.leading)
        }

    }
    
    private func updateSelectedCoin(coin:CoinModel) {
        selectedCoin = coin
        
        if
            let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
            let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        }else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0.0
    }
    
    private var portfolioInputSection:some View {
        VStack(spacing:20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice?.asCurrencyWith6Decimal() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            
            HStack{
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimal())
            }
        }
        .animation(.none,value: 0)
        .padding()
        .padding(.top,10)
        .font(.headline)
    }
    
    private var trailingNavBarButtons:some View {
        HStack(spacing:10) {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
                .foregroundColor(Color.theme.accent)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)

        }
        .font(.headline)

    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else {return}
        
        // Save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount )
        
        
        //Show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
            
        }
        
        //Hide keyboard
        UIApplication.shared.endEditing()
        
        //Hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    
}
