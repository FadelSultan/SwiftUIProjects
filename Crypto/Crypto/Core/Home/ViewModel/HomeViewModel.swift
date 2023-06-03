//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Fadel Sultan on 08/11/1444 AH.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject {
    
    @Published var statistics = [
        StatisticModel(title: "Title", value: "Value" , percentageChange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value" , percentageChange: -5),
    ]
    
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    @Published var searchText:String = ""
    
    private let dataService = CoinDataService()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscription() 
    }
    
    private func addSubscription() {
        //By this publisher we gets all coins and updateed
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] retuenedCoins in
                self?.allCoins = retuenedCoins
            }.store(in: &cancellable)
            
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
