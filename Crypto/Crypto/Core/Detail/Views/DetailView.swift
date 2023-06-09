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
    
    let coin:CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initailaizing for detail view \(coin.name) ")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
