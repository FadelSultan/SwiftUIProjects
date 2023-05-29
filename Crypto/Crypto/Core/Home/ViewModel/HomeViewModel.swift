//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Fadel Sultan on 08/11/1444 AH.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject {
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscription() 
    }
    
    private func addSubscription() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }.store(in: &cancellable)
    }
}
