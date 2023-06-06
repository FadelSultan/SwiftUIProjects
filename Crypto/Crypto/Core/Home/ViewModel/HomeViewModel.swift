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
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscription() 
    }
    
    private func addSubscription() {
        
        //By this publisher we gets all coins and updated
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }.store(in: &cancellable)
            
        
        //Update Portfolio
        $allCoins
            .combineLatest(portfolioDataService.$savedEntity)
            .map(mapGlobal)
            .sink {[weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellable)
        
        //Update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketData)
            .sink { [weak self] returnedStatistics in
                self?.statistics = returnedStatistics
                
            }
            .store(in: &cancellable)
        
    }

    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func mapMarketData(marketDataModel:MarketDataModel? , portfolioCoins:[CoinModel]) -> [StatisticModel] {
        
        var stats:[StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCup = StatisticModel(title: "Market Cup", value: data.marketCap , percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominace)
        
        
        let portfolioValue = portfolioCoins
                                .map({$0.currentsHoldingsValue})
                                .reduce(0, +)
        
        let previousValue =
        portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentsHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        
        let percentageChange = ((portfolioValue - previousValue) /  previousValue) * 100
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimal(),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCup,
            volume,
            btcDominance,
            portfolio
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
    
    private func mapGlobal(coinModels:[CoinModel] ,portfolioEntities:[PortfolioEntity] ) -> [CoinModel] {
        coinModels.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioEntities.first(where: {$0.coinId == coin.id}) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }

    }
}
