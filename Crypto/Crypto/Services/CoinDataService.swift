//
//  CoinDataService.swift
//  Crypto
//
//  Created by Fadel on 09/11/1444 AH.
//

import Foundation
import Combine


class CoinDataService {
    
    @Published var allCoins:[CoinModel] = []
    
    var coinSubscription:AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
//        per_page=250
        guard
            let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else {return}
        
        coinSubscription = NetworkingManagement.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManagement.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
            

        
    }
    
}
