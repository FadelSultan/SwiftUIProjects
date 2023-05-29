//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Fadel Sultan on 08/11/1444 AH.
//

import Foundation


class HomeViewModel:ObservableObject {
    @Published var allCoins:[CoinModel] = []
    @Published var protfolioCoins:[CoinModel] = []
    
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperProvider.instance.coin)
            self.protfolioCoins.append(DeveloperProvider.instance.coin)
        }
    }
}
