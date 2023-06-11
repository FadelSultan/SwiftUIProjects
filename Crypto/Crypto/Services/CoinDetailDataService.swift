//
//  CoinDetailDataService.swift
//  Crypto
//
//  Created by Fadel Sultan on 20/11/1444 AH.
//


import Foundation
import Combine


class CoinDetailDataService {
    
    @Published var coinDetails:CoinDetailsModel? = nil
    
    var coinDetailSubscription:AnyCancellable?
    let coin:CoinModel
    
    init(coin:CoinModel) {
        self.coin = coin
        getCoinsDetail()
    }
    
    func getCoinsDetail() {
//        per_page=250
        
//        https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
        
        guard
            let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else {return}
        
        coinDetailSubscription = NetworkingManagement.download(url: url)
            .decode(type: CoinDetailsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManagement.handleCompletion, receiveValue: { [weak self] returnedCoinDetail in
                self?.coinDetails = returnedCoinDetail
                self?.coinDetailSubscription?.cancel()
            })
             

        
    }
    
}
