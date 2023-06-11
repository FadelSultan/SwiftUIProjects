//
//  CoinDetailViewModel.swift
//  Crypto
//
//  Created by Fadel Sultan on 20/11/1444 AH.
//

import Foundation
import Combine


class CoinDetailViewModel:ObservableObject {
    
    @Published var coinDetail:CoinDetailModel? = nil
    
    let coin:CoinModel
    private let coinDetailService:CoinDetailDataService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin:CoinModel) {
        coinDetailService = CoinDetailDataService(coin: coin)
        self.coin = coin
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetail in
                self?.coinDetail = returnedCoinDetail
                print("[😇] Received Coin Detail Data")
                print(returnedCoinDetail ?? "" )
            }
            .store(in: &cancellable)
    }
}
