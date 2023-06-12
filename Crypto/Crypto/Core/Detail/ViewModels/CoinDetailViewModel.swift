//
//  CoinDetailViewModel.swift
//  Crypto
//
//  Created by Fadel Sultan on 20/11/1444 AH.
//

import Foundation
import Combine


class CoinDetailViewModel:ObservableObject {
    
    @Published var overviewStatistics:[StatisticModel] = []
    @Published var additionalStatistics:[StatisticModel] = []
    
    @Published var coin:CoinModel
    private let coinDetailService:CoinDetailDataService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin:CoinModel) {
        coinDetailService = CoinDetailDataService(coin: coin)
        self.coin = coin
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapData)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overView
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellable)
    }
    
    private func mapData(coinDetail:CoinDetailModel? , coin:CoinModel) -> (overView:[StatisticModel] , additional:[StatisticModel]) {
        let overViewArray = createOverviewArray(coin: coin)
        let additionalArray = createAdditionalArray(coinDetail: coinDetail, coin: coin)
        return (overViewArray , additionalArray)
    }
    
    private func createOverviewArray(coin:CoinModel) -> [StatisticModel] {

        let price = coin.currentPrice?.asCurrencyWith6Decimal()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price ?? "" , percentageChange: pricePercentChange)
        
        let marketCup = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCupPercentChange = coin.marketCapChangePercentage24H
        let marketCupStat = StatisticModel(title: "Market Capitalization", value: marketCup , percentageChange: marketCupPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overViewArray: [StatisticModel] = [
            priceStat , marketCupStat , rankStat , volumeStat
        ]
        
        return overViewArray
    }
    
    private func createAdditionalArray(coinDetail:CoinDetailModel? , coin:CoinModel) -> [StatisticModel] {

        let high = coin.high24H?.asCurrencyWith6Decimal() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith6Decimal() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimal() ?? "n/a"
        let pricePercentChange = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange,percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapChangeState = StatisticModel(title: "24h Market Cap Change", value: marketCapChange , percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray:[StatisticModel] = [
            highStat, lowStat , priceChangeStat , marketCapChangeState , blockStat , hashingStat
        ]
        
        return additionalArray
    }
}
