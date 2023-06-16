//
//  CoinImageService.swift
//  Crypto
//
//  Created by Fadel on 11/11/1444 AH.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image:UIImage? = nil
    
    private var imageSubscription:AnyCancellable?
    private let coin:CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName:String
    
    init(coin:CoinModel) {
        self.coin = coin
        imageName = coin.id
        
        getCoinImage()
    }
    
    private func  getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName)  {
            image = savedImage
        }else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        
        guard let url = URL(string: coin.image ?? "") else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] data in
                
                guard let self = self , let downloadedImage = UIImage(data: data) else {return}
                
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
