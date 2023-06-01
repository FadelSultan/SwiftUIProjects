//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by Fadel on 12/11/1444 AH.
//

import Foundation
import Combine
import SwiftUI

class CoinImageViewModel:ObservableObject {
    
    
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    
    private let dataService:CoinImageService
    private var cancellable = Set<AnyCancellable>()
    private let coin:CoinModel
    
    init(coin:CoinModel) {
        self.coin = coin
        dataService = CoinImageService(coin: coin)
        coinImageSubscription()
        self.isLoading = true
    }
    
    private func coinImageSubscription() {
        dataService.$image
            .sink { [weak self]  _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellable)

    }
    
}
