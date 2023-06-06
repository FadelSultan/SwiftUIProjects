//
//  MarketDataService.swift
//  Crypto
//
//  Created by Fadel Sultan on 14/11/1444 AH.
//

import Foundation
import Combine


class MarketDataService {
    
    @Published var marketData:MarketDataModel? = nil
    
    var marketSubscription:AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard
            let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else {return}
        
        marketSubscription = NetworkingManagement.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManagement.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketSubscription?.cancel()
            })
            

        
    }
    
}
