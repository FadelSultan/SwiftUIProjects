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
    @Published var isLoading:Bool = false
    @Published var sortOption:SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    
    enum SortOption {
        case rank , rankReversed , holdings , holdingsReversed , price , priceReversed
    }
    
    init() {
        addSubscription() 
    }
    
    private func addSubscription() {
        
        //By this publisher we gets all coins and updated
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }.store(in: &cancellable)
            
        
        //Update Portfolio
        $allCoins
            .combineLatest(portfolioDataService.$savedEntity)
            .map(mapGlobal)
            .sink {[weak self] returnedCoins in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellable)
        
        //Update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketData)
            .sink { [weak self] returnedStatistics in
                self?.statistics = returnedStatistics
                self?.isLoading = false
            }
            .store(in: &cancellable)
        
    }

    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
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
        
        
        let percentageChange = ((portfolioValue - previousValue) /  previousValue)
        
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
    
    private func filterAndSortCoins(text:String , coins:[CoinModel] , sort:SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort:SortOption , coins: inout [CoinModel]) {
        switch sort {
        case .rank , .holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed , .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice ?? 0 > $1.currentPrice ?? 0})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice ?? 0 < $1.currentPrice ?? 0})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins:[CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings :
            return coins.sorted(by: {$0.currentsHoldingsValue > $1.currentsHoldingsValue })
        case .holdingsReversed :
            return coins.sorted(by: {$0.currentsHoldingsValue < $1.currentsHoldingsValue })
        default:
            return coins
        }
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
