//
//  DetailView.swift
//  Crypto
//
//  Created by Fadel Sultan on 20/11/1444 AH.
//

import SwiftUI

struct DetailLoadingView:View {
    
    @Binding var coin:CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm:CoinDetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        print("Initailaizing for detail view \(coin.name) ")
    }
    
    var body: some View {
        ZStack {
            Text(vm.coinDetail?.id ?? "")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
