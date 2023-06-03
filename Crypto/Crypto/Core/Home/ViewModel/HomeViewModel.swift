//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Fadel Sultan on 08/11/1444 AH.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject {
    
    @Published var statistics:[StatisticModel] = []
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    @Published var searchText:String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscription() 
    }
    
    private func addSubscription() {
        
        //By this publisher we gets all coins and updateed
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] retuenedCoins in
                self?.allCoins = retuenedCoins
            }.store(in: &cancellable)
            
        marketDataService.$marketData
            .map(mapMarketData)
            .sink { [weak self] returnedStatistics in
                self?.statistics = returnedStatistics
                
            }
            .store(in: &cancellable)
            
        
    }

    private func mapMarketData(marketDataModel:MarketDataModel?) -> [StatisticModel] {
        
        var stats:[StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCup = StatisticModel(title: "Market Cup", value: data.marketCap , percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominace = StatisticModel(title: "BTC Dominace", value: data.btcDominace)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00",percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCup,
            volume,
            btcDominace
            ,portfolio
        ])
        
        return stats
    }
    
    private func filterCoins(text:String , coins:[CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        return coins.filter({
            $0.name.lowercased().contains(lowercasedText) ||
            $0.symbol.lowercased().contains(lowercasedText) ||
            $0.id.lowercased().contains(lowercasedText)
        })
    }
}
